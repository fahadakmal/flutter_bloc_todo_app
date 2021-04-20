import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repositery.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repositery repositery;

  TodosCubit({this.repositery}) : super(TodosInitial());

  void fetchTodosMthod() {
    Timer(Duration(seconds: 3), () {
      repositery.fetchTodosMthod().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repositery
        .changeCompletion(!todo.isCompleted, todo.id)
        .then((isChanged) => {
              if (isChanged)
                {
                  todo.isCompleted = !todo.isCompleted,
                  updateTodoList(),
                }
            });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded)
      emit(TodosLoaded(todos: currentState.todos));
  }

  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoListAfter =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodosLoaded(todos: todoListAfter));
    }
  }
}
