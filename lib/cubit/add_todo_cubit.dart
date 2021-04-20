import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/repositery.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repositery repositery;
  final TodosCubit todosCubit;

  AddTodoCubit({this.todosCubit, this.repositery}) : super(AddTodoInitial());

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: 'Message is Empty'));
      return;
    }

    emit(AddInTodo());

    Timer(Duration(seconds: 2), () {
      repositery.addTodo(message).then((todo) => {
            if (todo != null)
              {
                todosCubit.addTodo(todo),
                emit(TodoAdded()),
              }
          });
    });
  }
}
