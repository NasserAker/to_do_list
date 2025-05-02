import 'package:flutter/material.dart';
import 'package:to_do_list/util/myButton.dart';

// ignore: camel_case_types, must_be_immutable
class dialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  dialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel}
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter a New Task", border: OutlineInputBorder()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Mybutton(buttonName: "Save", onPressed: onSave),
                Mybutton(buttonName: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
