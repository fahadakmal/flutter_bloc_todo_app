class Todo {
  String todoMessage;
  bool isCompleted;
  int id;

  Todo.fromJSON(Map json)
      : todoMessage = json['todoMessage'],
        isCompleted = json['isCompleted'] == "true",
        id = json['id'] as int;
}
