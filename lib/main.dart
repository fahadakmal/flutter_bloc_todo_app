import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/presentation/router/router.dart';
import 'package:todo_app/presentation/screens/todos_screen.dart';

import 'data/repositery.dart';

void main() {
  final Repositery repositery = Repositery(networkService: NetworkService());
  runApp(MyApp(
    appRouter: AppRouter(),
    repositery: repositery,
    todosCubit: TodosCubit(repositery: repositery),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  final Repositery repositery;
  final TodosCubit todosCubit;

  const MyApp({Key key, this.appRouter, this.repositery, this.todosCubit})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: todosCubit),
        BlocProvider<AddTodoCubit>(
          create: (BuildContext context) =>
              AddTodoCubit(repositery: repositery, todosCubit: todosCubit),
        ),
        BlocProvider<EditTodoCubit>(
          create: (BuildContext context) =>
              EditTodoCubit(repositery: repositery, todosCubit: todosCubit),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosScreen(),
      ),
    );
  }
}
