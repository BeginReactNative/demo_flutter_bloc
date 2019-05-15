import 'package:bloc/bloc.dart';
import 'package:bloc_partten/blocs/todo/todo_bloc.dart';
import 'package:bloc_partten/blocs/todo/todo_repository.dart';
import 'package:bloc_partten/screens/demo_todo/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/post_bloc_delegate.dart';
import 'screens/home_page/home_page.dart';
import 'screens/demo_list/posts_screen.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TodoBloc _todoBloc;
  TodoRepository _todoRepository = TodoRepository();
  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc(repository: _todoRepository);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _todoBloc,
      child: MaterialApp(
        title: 'Flutter Demo Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoScreen(),
      ),
    );
  }
}
