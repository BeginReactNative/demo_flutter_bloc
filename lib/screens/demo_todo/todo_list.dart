import 'package:bloc_partten/blocs/todo/index.dart';
import 'package:bloc_partten/blocs/todo/todo.dart';
import 'package:bloc_partten/blocs/todo/todo_repository.dart';
import 'package:bloc_partten/screens/demo_todo/todo_detail.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoBloc _todoBloc;
  @override
  void initState() {
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
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
        } else if (state is TodoStateLoading) {
          return Center(
            child: Text("Todo empty"),
          );
        } else if (state is TodoStateLoaded) {
          return Container(
            child: ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (BuildContext context, int index) {
                Todo item = state.todos[index];
                return (item == null) ? Container(child:  null,) : new TodoItem(
                    todo: item,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return TodoDetail(todo: item);
                        }),
                      );
                    },
                    onCheckboxChanged: (_) {
                      _todoBloc.dispatch(UpdateTodoEvent(
                          item.copyWith(complete: !item.complete)));
                    }) ;
              },
            ),
          );
        }
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool> onCheckboxChanged;
  final GestureTapCallback onTap;
  const TodoItem(
      {Key key,
      @required this.todo,
      @required this.onCheckboxChanged,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.complete,
        onChanged: onCheckboxChanged,
      ),
      onTap: onTap,
      title: Hero(
        tag: todo.id,
        child: Container(
          child: Text(todo.task, style: Theme.of(context).textTheme.title),
        ),
      ),
      subtitle: Text(todo.note),
    );
  }
}
