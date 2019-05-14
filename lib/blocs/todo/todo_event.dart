import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'todo.dart';

@immutable
abstract class TodoEvent extends Equatable {
  TodoEvent([List props = const []]) : super(props);
}

class LoadTodoEvent extends TodoEvent {
  @override
  String toString() {
    return 'LoadTodoEvent';
  }
}
class AddTodoEvent extends TodoEvent {
  final Todo todo;
  AddTodoEvent(this.todo) : super([todo]);
  @override
  String toString() {
    return 'LoadTodoEvent';
  }
}
class UpdateTodoEvent extends TodoEvent {
   final Todo updateTodo;
  UpdateTodoEvent(this.updateTodo) : super([updateTodo]);
  @override
  String toString() {
    return 'UpdateTodoEvent';
  }
}
class RemoveTodoEvent extends TodoEvent {
  final Todo deleteTodo;
  RemoveTodoEvent(this.deleteTodo) : super([deleteTodo]);
  @override
  String toString() {
    return 'RemoveTodoEvent';
  }
}
class ClearAllTodoEvent extends TodoEvent {
  @override
  String toString() {
    return 'ClearAllTodoEvent';
  }
}
class ToggleAllTodoEvent extends TodoEvent {
  @override
  String toString() {
    return 'ToggleAllTodoEvent';
  }
}