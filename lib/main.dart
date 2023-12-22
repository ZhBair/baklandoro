import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {



// the buisness logic
int seconds = 0, minutes = 25, hours = 0;
String digitSeconds = "00", digitMinutes = "25", digitHours = "00";
Timer? timer;
bool started = false;
List laps = [];

//creat stop timer function

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

//creat RESET function

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 25;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "25";
      digitHours = "00";

      started = false;

    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //creat START function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds == 0) {
        if (localMinutes == 0) {
          localHours--;
          localMinutes = 59;
        } else {
          localMinutes--;
          localSeconds = 60;
        }
      }
      localSeconds--;
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ?"$seconds":"0$seconds";
        digitMinutes = (minutes >= 10) ?"$minutes":"0$minutes";
        digitHours = (hours >= 10) ?"$hours":"0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151026),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("Baklandoro App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              /*Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0x00151016),
                ),
                //add in list build
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n*${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              */
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ?start():stop();
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)),
                      child: Text(
                        (!started) ? "Start" : "Pause",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  /*
                  SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        addLaps();
                      },
                      icon: Icon(Icons.flag)),
                  SizedBox(
                    width: 8.0,
                  ),
                   */
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                        },
                      fillColor: Colors.blue,
                      shape: StadiumBorder(),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
