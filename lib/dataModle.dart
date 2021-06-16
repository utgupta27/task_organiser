// import 'dart:convert';
// import 'package:flutter/material.dart';

// TodoModle TodoFromJson(String str) {
//   final jsonData = json.decode(str);
//   return TodoModle.fromMap(jsonData);
// }

// String TodoToJson(TodoModle data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }

// class TodoModle {
//   int id;
//   String title;
//   String subTitle;
//   Color priority;
//   String dueDate;
//   String date;

//   TodoModle(
//       {required this.id,
//       required this.title,
//       required this.subTitle,
//       required this.priority,
//       required this.dueDate,
//       required this.date});
// //
//   factory TodoModle.fromMap(Map<String, dynamic> json) => new TodoModle(
//       id: json["id"],
//       title: json["title"],
//       subTitle: json["subTitle"],
//       priority: json["priority"],
//       dueDate: json["dueDate"],
//       date: json["date"]);

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "subTitle": subTitle,
//         "priority": priority,
//         "dueDate": dueDate,
//         "date": date
//       };
// }
