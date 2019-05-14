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
    if(event is LoadTodoEvent) {
      yield* _loadTodo();
    } else if(event is AddTodoEvent) {
      yield* _addTodo(event);
    } else if ( event is UpdateTodoEvent) {
      return;
    } else if ( event is RemoveTodoEvent) {
      return;
    } else if ( event is ClearAllTodoEvent) {
      return;
    } else if ( event is ToggleAllTodoEvent) {
      return;
    }
  }
  Stream<TodoState> _loadTodo() async* {
    try {
      final todos = await this.repository.loadTodos();
      yield TodoStateLoaded(todos);
    } catch (_) {
       yield TodoStateLoadError();
    }
  }
  Stream<TodoState> _addTodo(AddTodoEvent event) async* {
    final List<Todo> updatedTodos = (currentState as TodoStateLoaded).todos..add(event.todo);
    yield TodoStateLoaded(updatedTodos);
    _saveTodo(event.todo);
  }
  Future _saveTodo(Todo todo) async {
    this.repository.saveTodo(todo);
  }
}
