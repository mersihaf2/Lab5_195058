import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import './auth_screen.dart';
import './listCourse.dart';
import 'auth.dart';
import './newCourse.dart';
import '../models/course.dart';
import 'calendar.dart';
import 'location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Student Organizer',
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.blue,
            errorColor: Colors.red,
            fontFamily: 'Quicksand'),
        home: AuthScreen(),
        routes: {'/courses': ((context) => MyHomePage())},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Course> _courseList = [
    Course(
        name: 'Informaciska bezbednost',
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Course(
        name: 'Mobilni informaciski sistemi',
        date: DateTime.now(),
        id: DateTime.now().toString()),
  ];

  void _startAddingNewCourse(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(onTap: () {}, child: NewCourse(_addNewCourse));
      },
    );
  }

  void _addNewCourse(String name, DateTime date) {
    var url = Uri.https(
      'studentorganizer-10243-default-rtdb.firebaseio.com',
      '/courses.json',
    );

    http.post(url,
        body: json.encode({
          'title': name,
          'date': date.toString(),
        }));
    setState(() {
      _courseList
          .add(Course(name: name, date: date, id: DateTime.now().toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('Student Organizer'),
          actions: [
            IconButton(
                onPressed: () => _startAddingNewCourse(context),
                icon: Icon(Icons.add)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(_courseList),
                  ),
                  // arguments: {'onAddAccount': onAddAccount},
                );
              },
              icon: Icon(Icons.calendar_month),
            ),
            IconButton(
              icon: Icon(Icons.location_pin),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LocationService()));
              },
            )
          ],
        ),
        body: Container(
          child: Column(children: [
            Container(child: CourseList(_courseList)),
          ]),
        ),
      ),
    );
  }
}
