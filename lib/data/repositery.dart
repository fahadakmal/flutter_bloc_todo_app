import 'package:todo_app/data/network_service.dart';

import 'models/todo.dart';

class Repositery {
  final NetworkService networkService;

  Repositery({this.networkService});
  Future<List<Todo>> fetchTodosMthod() async {
    final todosRaw = await networkService.fetchTodos();
    print(todosRaw);
    return todosRaw.map((e) => Todo.fromJSON(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String message) async {
    final todoObj = {"todoMessage": message, "isCompleted": "false"};
    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap == null) return null;
    return Todo.fromJSON(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final updatedObj = {"todoMessage": message};
    return await networkService.patchTodo(updatedObj, id);
  }
}
