import 'package:bloc_partten/blocs/home_tabs/index.dart';
import 'package:bloc_partten/blocs/todo/todo_bloc.dart';
import 'package:bloc_partten/screens/demo_todo/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tab_selector.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key}) : super(key: key);

  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  HomeTabsBloc _tabsBloc = HomeTabsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _tabsBloc,
      builder: (BuildContext context, HomeTab activatedTab) {
        return BlocProviderTree(
          blocProviders: [
            BlocProvider<HomeTabsBloc>(bloc: _tabsBloc),
            // other bloc
          ],
          child: Scaffold(
              appBar: AppBar(
                title: Text("Demo Todo"),
              ),
              body: (activatedTab == HomeTab.todos)
                  ? TodoList()
                  : Center(
                      child: Text("Stat Screen"),
                    ),
              bottomNavigationBar: new TabSelector()),
        );
      },
    );
  }
}

