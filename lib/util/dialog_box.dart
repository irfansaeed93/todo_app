import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
   DialogBox({
     super.key,
     required this.controller,
     required this.onCancel,
     required this.onSave});

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
                controller: controller,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add new task',
              ),
            ),

            // buttons save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // save button
                MyButton(text: 'Save', onPressed: onSave),
                SizedBox(width: 8,),
                // cancel button
                MyButton(text: 'Cancel', onPressed: onCancel)

              ],
            )


          ],
        ),
      ),
    );
  }
}
