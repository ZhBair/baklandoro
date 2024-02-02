import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

/*
https://coolors.co/palette/ea698b-d55d92-c05299-ac46a1-973aa8-822faf-6d23b6-6411ad-571089-47126b
flutter
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  bool orient = true;

//creat stop timer function

  void stop() {
    FlutterRingtonePlayer().stop();
    timer?.cancel();
    timerDialog?.cancel();
    setState(() {
      started = false;
    });
  }

//creat RESET function

  void _resetInternal() {
    FlutterRingtonePlayer().stop();
    timer?.cancel();
    timerDialog?.cancel();
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

  Future<void> reset() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON).then((value) => _resetInternal());
  }

  void addLaps() {
    int? j = map["job"];
    String lap = "JOB : $j";
    setState(() {
      laps.add(lap);
    });
  }

  void _startInternal() {
    started = true;
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //change seconds to milis
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
        if (map["job"] == 0) {
          map["job"] = 1;
          localMinutes = 5;
          colorText = Colors.green;
          addLaps();
          relax = true;
        } else if (map["job"] == 1 && map["shortBreak"] == 0) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        } else if (map["job"] == 1 && map["shortBreak"] == 1) {
          localMinutes = 5;
          colorText = Colors.green;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        } else if (map["job"] == 2 && map["shortBreak"] == 1) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        } else if (map["job"] == 2 && map["shortBreak"] == 2) {
          localMinutes = 5;
          colorText = Colors.green;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        } else if (map["job"] == 3 && map["shortBreak"] == 2) {
          localMinutes = 25;
          colorText = Colors.white;
          map["shortBreak"] = map["shortBreak"]! + 1;
          relax = false;
        } else if (map["job"] == 3 && map["shortBreak"] == 3 && map["longBreak"] == 0) {
          localMinutes = 15;
          colorText = Colors.greenAccent;
          map["longBreak"] = map["longBreak"]! + 1;
          map["job"] = map["job"]! + 1;
          addLaps();
          relax = true;
        } else if (map["job"] == 4 && map["shortBreak"] == 3 && map["longBreak"] == 1) {
          colorText = Colors.red;
          stop();
        }
      }
      localSeconds--;
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  //creat START function
  Future<void> start() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON).then(
      (value) => _startInternal(),
    );
  }

  //view gialog windows
  void showDiaolog() {
    stop();
    FlutterRingtonePlayer().playNotification(looping: false);
    bool flag = false;
    int sec = 0;
    timerDialog = Timer.periodic(const Duration(seconds: 1), (timerDialog) {
      sec++;
      if (sec == 10) {
        timerDialog.cancel();
        if (!flag) {
          Navigator.pop(context);
          start();
        }
      }
      print('done $sec');
    });

    if (map["longBreak"] != 1) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              //or CupertinoAlertDialog
              backgroundColor: const Color(0xFF47126B),
              title: const Text(
                "Attention",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    start();
                    Navigator.pop(context);
                    flag = true;
                  },
                  minWidth: 50.0,
                  color: const Color(0xFFEA698B),
                  child: const Text(
                    "Continue",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                MaterialButton(
                  onPressed: () {
                    reset();
                    Navigator.pop(context);
                  },
                  minWidth: 100.0,
                  color: const Color(0xFF973AA8),
                  child: const Text(
                    "Stop",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
    } else {
      flag = true;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF47126B),
              title: const Text(
                "Congratulations!",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    reset();
                    start();
                    Navigator.pop(context);
                  },
                  minWidth: 100.0,
                  color: const Color(0xFF973AA8),
                  child: const Text(
                    "Start again?",
                    style: TextStyle(color: Colors.white),
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
      backgroundColor: const Color(0xFF47126B), // old 0xFF151026
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrientationBuilder(
            builder: (context, orientation) =>
            orientation == Orientation.portrait
                ? buildPortrait()
                : buildLandscape(),
          ),
        ),
        ),
      );

  }

  Widget buildPortrait() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text("Baklandoro App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: colorText,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.rotate_left),
                      color: const Color(0xFF973AA8),
                      onPressed: () {
                        if (orient){
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft]);
                          orient = false;
                        }
                        else{
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                          orient = true;
                        }
                      },
                    ),
                  ),
                ),
              ],
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
            decoration: const BoxDecoration(
              color: Color(0x00151016),  //0x00151016
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
                        "${laps[index]}",
                        style: const TextStyle(
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
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  shape: const StadiumBorder(side: BorderSide(color: Color(0xFF6411AD))), //0xFF973AA8
                  child: Text(
                    (!started) ? "Start" : "Pause",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    reset();
                  },
                  fillColor: const Color(0xFF6411AD),
                  shape: const StadiumBorder(),
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget buildLandscape() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10),
                    child: Text(
                      "$digitHours:$digitMinutes:$digitSeconds",
                      style: TextStyle(
                        color: colorText,
                        fontSize: 140.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.rotate_left),
                        color: const Color(0xFF973AA8),
                        onPressed: () {
                          if (orient){
                            SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.landscapeLeft]);
                            orient = false;
                          }
                          else{
                            SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.portraitUp]);
                            orient = true;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              (!started) ? "" : ((!relax) ? "Keep Working" : "Relax"),
              style: TextStyle(
                color: colorText,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 0.0,
            decoration: const BoxDecoration(
              color: Colors.green,  //0x00151016
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
                        "${laps[index]}",
                        style: const TextStyle(
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
          const SizedBox(
            height: 0.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  shape: const StadiumBorder(side: BorderSide(color: Color(0xFF6411AD))), //0xFF973AA8
                  child: Text(
                    (!started) ? "Start" : "Pause",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    reset();
                  },
                  fillColor: const Color(0xFF6411AD),
                  shape: const StadiumBorder(),
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
