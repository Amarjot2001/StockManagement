import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final VoidCallback buttonTap;
  final String name;

  const PrimaryBtn({super.key, required this.buttonTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonTap,
      style: ElevatedButton.styleFrom(
          elevation: 12.0, textStyle: const TextStyle(color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
