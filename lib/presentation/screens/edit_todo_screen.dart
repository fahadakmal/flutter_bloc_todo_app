import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({Key key, this.todo}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Toast.show(state.error, context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.CENTER,
              backgroundColor: Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Todo'),
          actions: [
            InkWell(
                onTap: () {
                  BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
                },
                child: Padding(
                    padding: EdgeInsets.all(13.0), child: Icon(Icons.delete))),
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            autocorrect: true,
            decoration: InputDecoration(hintText: "Enter todo message"),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            child: _updateButton(context),
            onTap: () {
              BlocProvider.of<EditTodoCubit>(context)
                  .updateTodo(todo, _controller.text);
            },
          )
        ],
      ),
    );
  }

  Widget _updateButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
      child: Center(child: BlocBuilder<EditTodoCubit, EditTodoState>(
        builder: (context, state) {
          // if (state is AddInTodo) return CircularProgressIndicator();
          return Text(
            'Update Todo',
            style: TextStyle(color: Colors.white),
          );
        },
      )),
    );
  }
}
