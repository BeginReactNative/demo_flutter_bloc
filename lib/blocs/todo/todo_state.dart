import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'todo.dart';
@immutable
abstract class TodoState extends Equatable {
  TodoState([List props = const []]) : super(props);
}

class InitialTodoState extends TodoState {}

class TodoStateLoading extends TodoState {
  @override
  String toString() {
    return 'TodoStateLoading';
  }
}
class TodoStateLoaded extends TodoState {
  final List<Todo> todos;
  TodoStateLoaded([this.todos = const []]) : super(todos);
  @override
  String toString() {
    return 'TodosLoaded { todos: $todos }';
  }
}
class TodoStateLoadError extends TodoState {
  @override
  String toString() {
    return 'TodoStateLoadError';
  }
}
