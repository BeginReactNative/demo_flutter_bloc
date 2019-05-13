import 'dart:convert';

import 'blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_partten/models/models.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  PostBloc({this.httpClient});
  @override
  PostState get initialState => PostLoading();
  @override
  Stream<PostState> transform(Stream<PostEvent> events, Stream<PostState> Function(PostEvent event) next) {
    // transform called before currentState updated ,
    return super.transform(events, next);
  }
  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostLoading) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        } else if (currentState is PostLoaded) {
          final posts =
              await _fetchPosts((currentState as PostLoaded).posts.length, 20);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawMap) {
        return new Post.fromMap(rawMap);
      }).toList();
    } else {
      throw Exception("error fetching posts");
    }
  }
}
