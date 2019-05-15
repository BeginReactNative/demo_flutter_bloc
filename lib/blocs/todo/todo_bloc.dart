import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'index.dart';
import 'todo.dart';
import 'todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc({@required this.repository});
  @override
  TodoState get initialState => TodoStateLoading();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is LoadTodoEvent) {
      yield* _loadTodo();
    } else if (event is AddTodoEvent) {
      yield* _addTodo(event);
    } else if (event is UpdateTodoEvent) {
      yield* _updateTodo(event.updateTodo);
    } else if (event is RemoveTodoEvent) {
      yield* _removeTodo(event.deleteTodo);
    } else if (event is ClearAllTodoEvent) {
      return;
    } else if (event is ToggleAllTodoEvent) {
      return;
    }
  }

  Stream<TodoState> _loadTodo() async* {
    try {
      final todos = await this.repository.loadTodos();
      if (todos.length == 0) {
        yield TodoStateEmpty();
      } else {
        yield TodoStateLoaded(todos);
      }
    } catch (_) {
      yield TodoStateLoadError();
    }
  }

  Stream<TodoState> _updateTodo(Todo updateTodo) async* {
    if (currentState is TodoStateLoaded) {
      final List<Todo> newLists =
          (currentState as TodoStateLoaded).todos.map((todo) {
        return (todo.id == updateTodo.id) ? updateTodo : todo;
      }).toList();
      yield TodoStateLoaded(newLists);
    }
  }

  Stream<TodoState> _removeTodo(Todo deleteTodo) async* {
    if (currentState is TodoStateLoaded) {
      final List<Todo> afterDelete = (currentState as TodoStateLoaded).todos
        .where((todo) => todo.id != deleteTodo.id).toList();
        print(deleteTodo.id);
      yield TodoStateLoaded(afterDelete);
    }
  }

  Stream<TodoState> _addTodo(AddTodoEvent event) async* {
    final List<Todo> updatedTodos = (currentState as TodoStateLoaded).todos
      ..add(event.todo);
    yield TodoStateLoaded(updatedTodos);
    _saveTodo(event.todo);
  }

  Future _saveTodo(Todo todo) async {
    this.repository.saveTodo(todo);
  }
}
