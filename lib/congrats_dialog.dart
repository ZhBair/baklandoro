import 'package:flutter/material.dart';

class CongratsDialog extends StatelessWidget {
  final VoidCallback _callback;
  const CongratsDialog(this._callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF47126B),
      title: const Text(
        "Congratulations!",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        MaterialButton(
          onPressed: _callback,
          minWidth: 100.0,
          color: const Color(0xFF973AA8),
          child: const Text(
            "Start again?",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
