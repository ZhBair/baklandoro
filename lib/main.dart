import 'dart:async';

import 'package:baklandoro/landscape.dart';
import 'package:baklandoro/notifier/cycle.dart';
import 'package:baklandoro/notifier/timer.dart';
import 'package:baklandoro/portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => WorkTimer()),
      ChangeNotifierProvider(create: (ctx) => BreakTimer()),
      ChangeNotifierProvider(create: (ctx) => CycleCounter())
    ],
    child: const MaterialApp(
      home: HomeApp(),
    ),
  ));
}

/*
https://coolors.co/palette/ea698b-d55d92-c05299-ac46a1-973aa8-822faf-6d23b6-6411ad-571089-47126b
flutter
 */

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  bool started = false;
  Color colorText = Colors.white;
  bool orient = true;

//creat stop timer function

  void stop() {
    FlutterRingtonePlayer().stop();
  }

//creat RESET function

  Future<void> reset() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  Future<void> start() async {
    FlutterRingtonePlayer().stop();
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  void showDialog() {
    stop();
    FlutterRingtonePlayer().playNotification(looping: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF47126B), // old 0xFF151026
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrientationBuilder(
            builder: (context, orientation) => orientation == Orientation.portrait ? const PortraitContent() : const LandscapeContent(),
          ),
        ),
      ),
    );
  }
}
