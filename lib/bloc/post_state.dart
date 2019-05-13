import 'package:equatable/equatable.dart';
import 'package:bloc_partten/models/models.dart';

abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}
class PostLoading extends PostState {
  @override
  String toString() {
    return 'Post Loading';
  }
}
class PostError extends PostState {
  @override
  String toString() {
    return 'Post error';
  }
}
class PostLoaded extends PostState {
    List<Post> posts;
    bool hasReachedMax;
    PostLoaded({
      this.posts,
      this.hasReachedMax
    }): super([posts, hasReachedMax]);
    PostLoaded copyWith({List<Post> posts, bool hasReachedMax}) {
        return PostLoaded(
          posts: posts ?? this.posts,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax
        );
    }
      @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}