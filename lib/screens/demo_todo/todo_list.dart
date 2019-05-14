import 'package:bloc_partten/blocs/todo/index.dart';
import 'package:bloc_partten/blocs/todo/todo.dart';
import 'package:bloc_partten/blocs/todo/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoBloc _todoBloc;
  TodoRepository _repository = TodoRepository();
  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc(repository: _repository);
    _todoBloc.dispatch(LoadTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _todoBloc,
      builder: (BuildContext context, TodoState state) {
        if (state is TodoStateEmpty) {
          return Center(
            child: Text("Todo empty"),
          );
        }
        else if( state is TodoStateLoading) {
           return Center(
            child: Text("Todo empty"),
          );
        }
        else if (state is TodoStateLoaded) {
          return Container(
            child:  ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = state.todos[index];
                  return ListTile(
                    leading: Checkbox(value: item.complete, onChanged: null,),
                    title: Text(item.task),
                    subtitle: Text(item.note),
                  );
                },
              ),
          );
        }
      },
    );
  }
}
