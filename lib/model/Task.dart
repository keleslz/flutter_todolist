class Task {
  int id;

  String title;

  String detail;

  bool completed;

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        detail = json['title'],
        completed = json['completed'];
}
