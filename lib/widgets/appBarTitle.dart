import 'package:flutter/material.dart';
import 'package:task_organiser/res/customColors.dart';

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
        // Text(
        //   'Task',
        //   style: TextStyle(
        //     color: CustomColors.firebaseYellow,
        //     fontSize: 24,
        //   ),
        // ),
        // Text(
        //   ' Organiser',
        //   style: TextStyle(
        //     color: CustomColors.firebaseOrange,
        //     fontSize: 24,
        //   ),
        // ),
      ],
    );
  }
}
