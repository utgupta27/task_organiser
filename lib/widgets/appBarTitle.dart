import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/task_organiser.png',
          height: 33,
        ),
        SizedBox(width: 15),
        Text(
          "Task Organiser",
          style: TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
