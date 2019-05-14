import 'package:bloc_partten/blocs/home_tabs/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  ? Center(
                      child: Text("Todo Screen"),
                    )
                  : Center(
                      child: Text("Stat Screen"),
                    ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: HomeTab.values.indexOf(activatedTab),
                  onTap: (int index) {
                    HomeTab newTab = HomeTab.values[index];
                    _tabsBloc.dispatch(UpdateTab(tab: newTab));
                  },
                  items: HomeTab.values.map((tab) {
                    print(tab);
                    return BottomNavigationBarItem(
                        icon: Icon(
                          (tab == HomeTab.todos)
                              ? Icons.add
                              : Icons.menu,
                        ),
                        title: (tab == HomeTab.todos)
                            ? Text("Todos")
                            : Text("Stat"));
                  }).toList())),
        );
      },
    );
  }
}
