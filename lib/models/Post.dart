import 'package:equatable/equatable.dart';

class Post extends Equatable {
  int id;
  String title;
  String body;
  Post({
    this.id,
    this.title,
    this.body
  }) : super([id, title, body]);
  @override
  String toString() {
    return 'Post { id: $id }';
  }
  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
  }
}