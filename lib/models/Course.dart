class Course {
  String id;
  String name;
  DateTime date;

  Course({this.id, this.name, this.date});

  String getName() {
    return name;
  }

  DateTime getDate() {
    return date;
  }
}
