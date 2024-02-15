import 'package:baklandoro/notifier/timer.dart';
import 'package:baklandoro/timertext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortraitContent extends StatelessWidget {
  const PortraitContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Center(
          child: Column(
            children: [
              TimerText(),
            ],
          ),
        ),
        const Center(
          child: Text(
            "Zaglushka Relax/Work",
            style: TextStyle(
              color: Colors.white,
              fontSize: 42.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 200.0,
          decoration: const BoxDecoration(
            color: Color(0x00151016), //0x00151016
          ),
          //add in list build
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$index",
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
                  Provider.of<WorkTimer>(context, listen: false).startTimer(const Duration(minutes: 25));
                },
                shape: const StadiumBorder(side: BorderSide(color: Color(0xFF6411AD))), //0xFF973AA8
                child: const Text(
                  "Start",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: RawMaterialButton(
                onPressed: () {},
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
}
