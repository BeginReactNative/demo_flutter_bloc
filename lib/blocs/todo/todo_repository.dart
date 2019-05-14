

import 'todo.dart';

class TodoRepository {
  Future<List<Todo>> loadTodos() async {
    List<Todo> todos = new List<Todo>();
    return todos;
  }
  Future saveTodo(Todo todo) {
    print("save todo");
  }
}