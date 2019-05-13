import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'bloc/post_bloc_delegate.dart';
import 'screens/home_page/home_page.dart';
import 'screens/demo_list/posts_screen.dart';
void main() {
      BlocSupervisor().delegate = SimpleBlocDelegate();
		runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Bloc',
	  debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostsScreen(),
    );
  }
}




