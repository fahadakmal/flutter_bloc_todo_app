import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repositery.dart';
import 'package:todo_app/presentation/screens/add_todo_screen.dart';
import 'package:todo_app/presentation/screens/edit_todo_screen.dart';
import 'package:todo_app/presentation/screens/todos_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => TodosScreen());
        break;
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
            builder: (context) => EditTodoScreen(
                  todo: todo,
                ));
        break;
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(builder: (context) => AddTodoScreen());
        break;

      default:
        return null;
    }
  }
}
