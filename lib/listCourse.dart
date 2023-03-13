import 'package:flutter/material.dart';
import './models/course.dart';
import 'package:intl/intl.dart';

class CourseList extends StatelessWidget {
  final List<Course> _courseList;

  CourseList(this._courseList);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _courseList.map((c) {
      return Card(
        elevation: 6,
        child: Container(
          height: 60,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(
                  c.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  DateFormat.yMMMMd().format(c.date),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
