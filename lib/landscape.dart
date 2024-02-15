import 'package:flutter/material.dart';

class LandscapeContent extends StatelessWidget {
  const LandscapeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child: const Text(
                    "00:00:00 (time)",
                    style: TextStyle(
                      color: Colors.white,
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
                      icon: const Icon(Icons.rotate_right),
                      color: const Color(0xFF973AA8),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Center(
          child: Text(
            "Placeholder Relax",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 0.0,
          decoration: const BoxDecoration(
            color: Colors.green, //0x00151016
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
          height: 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RawMaterialButton(
                onPressed: () {},
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
