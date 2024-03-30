import 'package:flutter/material.dart';
import 'package:todoapp/utils/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancle;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancle});

      



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[200],
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //get user input
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task"),
          ),
          
          //buttons => save and cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButtons(text: 'Save', onpressed: onSave),
              const SizedBox(
                width: 10,
              ),
              MyButtons(text: 'Cancel', onpressed: onCancle),
            ],
          )
        ]),
      ),
    );
  }
}
