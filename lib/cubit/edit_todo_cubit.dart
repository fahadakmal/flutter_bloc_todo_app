import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repositery.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repositery repositery;
  final TodosCubit todosCubit;
  EditTodoCubit({this.repositery, this.todosCubit}) : super(EditTodoInitial());

  void deleteTodo(Todo todo) {
    emit(EditinOrDeletingTodo());

    repositery.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted) {
        todosCubit.deleteTodo(todo);
        emit(TodoEdited());
      }
    });
  }

  void updateTodo(Todo todo, String todoMessage) {
    if (todoMessage.isEmpty) {
      emit(EditTodoError('To do message is empty'));
      return;
    }
    emit(EditinOrDeletingTodo());

    repositery.updateTodo(todoMessage, todo.id).then((isUpdated) {
      if (isUpdated) {
        todo.todoMessage = todoMessage;
        todosCubit.updateTodoList();
        emit(TodoEdited());
      }
    });
  }
}
