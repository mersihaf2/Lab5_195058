import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/course.dart';

class Calendar extends StatelessWidget {
  List<Course> _courseList;
  Calendar(this._courseList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam dates")),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource(_courseList)),
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            navigationDirection: MonthNavigationDirection.horizontal),
        todayHighlightColor: Colors.deepPurple,
        showNavigationArrow: true,
        // on
      ),
    );
  }
}

List<Meeting> _getDataSource(_courseList) {
  final List<Meeting> meetings = <Meeting>[];
  _courseList.forEach((element) {
    final DateTime startTime = DateTime(
        element.date.year, element.date.month, element.date.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting(element.name, startTime, endTime, Colors.purpleAccent, false));
  });
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
