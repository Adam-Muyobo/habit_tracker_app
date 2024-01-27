import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  const EnterNewHabitBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: TextField(
        style: const TextStyle(
          color: Colors.black54
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: (){},
          color: Colors.grey[400],
          elevation: 0,
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        MaterialButton(
          onPressed: (){},
          color: Colors.grey[400],
          elevation: 0,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
