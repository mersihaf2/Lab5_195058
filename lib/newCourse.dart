import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewCourse extends StatefulWidget {
  final Function _addNewCourse;
  NewCourse(this._addNewCourse);

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  var _titleController = TextEditingController();
  DateTime date;

  void _submitData() {
    var _enteredTitle = _titleController.text;
    if (_enteredTitle == null || date == null) {
      return;
    }
    widget._addNewCourse(_enteredTitle, date);
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((value) {
      date = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        elevation: 6,
        child: TextField(
          controller: _titleController,
          decoration: InputDecoration(label: Text('Input the Course name')),
        ),
      ),
      Card(
        elevation: 6,
        child: Row(
          children: [
            date == null
                ? Text('The date is not chosen yet')
                : Text(DateFormat.yMMMMd().format(date)),
            TextButton(
                onPressed: _showDatePicker,
                child: Text('Pick a date to take the exam'))
          ],
        ),
      ),
      ElevatedButton(onPressed: _submitData, child: Text('Enter new exam date'))
    ]);
  }
}
