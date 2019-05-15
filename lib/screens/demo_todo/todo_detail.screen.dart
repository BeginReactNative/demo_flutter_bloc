import 'package:bloc_partten/blocs/todo/index.dart';
import 'package:bloc_partten/blocs/todo/todo.dart';
import 'package:bloc_partten/screens/demo_todo/todo_add_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDetail extends StatelessWidget {
  final Todo todo;
  const TodoDetail({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context);
    TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocBuilder(
      bloc: _todoBloc,
      builder: (BuildContext context, TodoState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Todo detail"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _todoBloc.dispatch(RemoveTodoEvent(todo));
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                child: Hero(
                  tag: todo.id,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      todo.task,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(todo.note),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddEditScreen(
                  todo: todo,
                  isEditing: true,
                  onSave: (String task, String note) {
                    _todoBloc.dispatch(
                        UpdateTodoEvent(todo.copyWith(task: task, note: note)));
                  },
                );
              }));
            },
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }
}
