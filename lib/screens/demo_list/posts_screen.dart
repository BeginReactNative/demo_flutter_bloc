import 'package:bloc/bloc.dart';
import 'package:bloc_partten/bloc/post_bloc_delegate.dart';
import 'package:bloc_partten/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/blocs.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  PostsScreen({Key key}) : super(key: key);

  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;
  _PostsScreenState() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
    });
    _postBloc.dispatch(Fetch());
  }
  @override
  void dispose() {
    _scrollController.dispose();
    _postBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostListBloc"),
      ),
      body: BlocBuilder(
        bloc: _postBloc,
        builder: (BuildContext context, PostState state) {
          if (state is PostLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostError) {
            return Center(child: Text(state.toString()));
          } else if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(child: Text('No posts'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
              itemBuilder: (BuildContext context, int index) {
                            print(state.toString());
               return index >= state.posts.length ? BottomLoader() : PostWidget(
                  post: state.posts[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: false,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}