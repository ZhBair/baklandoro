import 'package:flutter/material.dart';

class AttentionDialog extends StatelessWidget {
  final VoidCallback _onContinueCallback;
  final VoidCallback _onStopCallback;
  const AttentionDialog(this._onContinueCallback, this._onStopCallback, {super.key});

  @override
  Widget build(BuildContext context) {
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
          onPressed: _onContinueCallback,
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
          onPressed: _onStopCallback,
          minWidth: 100.0,
          color: const Color(0xFF973AA8),
          child: const Text(
            "Stop",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
