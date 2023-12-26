import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
/*
https://coolors.co/palette/ea698b-d55d92-c05299-ac46a1-973aa8-822faf-6d23b6-6411ad-571089-47126b

 */
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
Timer? timer, timerDialog;
bool started = false;
bool relax = false;
List laps = [];
Color colorText = Colors.white;
Map<String, int> map = {"job": 0, "shortBreak": 0, "longBreak": 0};

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

      colorText = Colors.white;
      started = false;
      relax = false;
      laps.clear();
      map = {"job": 0, "shortBreak": 0, "longBreak": 0};
    });
  }

  void addLaps() {
    int? j = map["job"];
    String lap = "JOB : $j";
    setState(() {
      laps.add(lap);
    });
  }

  //creat START function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) { //change seconds to milis
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
      if (localHours == 0 && localMinutes == 0 && localSeconds == 1) {
        showDiaolog();
        if (map["job"] == 0){
          map["job"] = 1;
          localMinutes = 5;
          colorText = Colors.green;
          addLaps();
          relax = true;
        }
        else if(map["job"] == 1 && map["shortBreak"] == 0) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        }
        else if (map["job"] == 1 && map["shortBreak"] == 1) {
          localMinutes = 5;
          colorText = Colors.green;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        }
        else if (map["job"] == 2 && map["shortBreak"] == 1) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        }
        else if (map["job"] == 2 && map["shortBreak"] == 2) {
          localMinutes = 5;
          colorText = Colors.green;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        }
        else if (map["job"] == 3 && map["shortBreak"] == 2) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        }
        else if (map["job"] == 3 && map["shortBreak"] == 3 && map["longBreak"] == 0) {
          localMinutes = 15;
          colorText = Colors.greenAccent;
          map["longBreak"] = map["longBreak"]! + 1;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        }
        else if (map["job"] == 4 && map["shortBreak"] == 3 && map["longBreak"] == 1) {
          colorText = Colors.red;
          stop();
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

  //view gialog windows
  void showDiaolog() {
    stop();
    /*
    int sec = 0;
    timerDialog = Timer.periodic(Duration(seconds: 1), (timerDialog) {

    });

     */
    if (map["longBreak"] != 1) {
      showDialog(context: context, builder: (context) {
        return AlertDialog( //or CupertinoAlertDialog
          backgroundColor: Color(0xFF47126B),
          title: Text(
            "Attention",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white
            ),
          ),
          actions: [
            MaterialButton(onPressed: () {
              start();
              Navigator.pop(context);
            },
              color: Color(0xFFEA698B),
              child: Text(
                "Continue",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            MaterialButton(onPressed: () {
              reset();
              Navigator.pop(context);
            },
              color: Color(0xFF973AA8),
              child: Text(
                "Stop",
                style: TextStyle(color: Colors.white
                ),
              ),
            ),
          ],
        );
      });
    }
    else
      {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF47126B),
            title: Text(
              "Congratulations!",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            actions: [
              MaterialButton(onPressed: () {
                reset();
                start();
                Navigator.pop(context);
              },
                color: Color(0xFF973AA8),
                child: Text(
                  "Start again?",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ],
          );
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF47126B), // old 0xFF151026
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
                    color: colorText,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  (!started) ? "" : ((!relax) ? "Keep Working" : "Relax"),
                  style: TextStyle(
                    color: colorText,
                    fontSize: 42.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 200.0,
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
                          /*
                          Text(
                            "Lap n*${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                           */
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
                          side: BorderSide(color: Color(0xFF6411AD))), //0xFF973AA8
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
                      fillColor: Color(0xFF6411AD),
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
