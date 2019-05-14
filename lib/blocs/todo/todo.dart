import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  String id;
  bool complete;
  String note;
  String task;
  Todo(this.task, {this.complete = false, String note = '', String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().v4(),
        super([complete, task, id, note]);
  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

}
