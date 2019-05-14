

import 'dart:math';

import 'todo.dart';

class TodoRepository {
  Future<List<Todo>> loadTodos() async {
    List<Todo> todos = new List<Todo>();
    todos..add(new Todo("task 1 ",note: "note 1",complete: randomActivated(),))
      ..add(new Todo("task 2 ",note: "note 2",complete: randomActivated(),))
      ..add(new Todo("task 3 ",note: "note 3",complete: randomActivated(),))
      ..add(new Todo("task 4 ",note: "note 4",complete: randomActivated(),))
      ..add(new Todo("task 5 ",note: "note 5",complete: randomActivated(),));

    return todos;
  }
  bool randomActivated() {
    int rand = new Random().nextInt(2);
    return (rand == 1) ? true : false;
  }
  Future saveTodo(Todo todo) {
    print("save todo");
  }
}