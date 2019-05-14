import 'package:bloc_partten/blocs/home_tabs/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tabsBloc = BlocProvider.of<HomeTabsBloc>(context);
    return BlocBuilder(
      bloc: _tabsBloc,
      builder: (BuildContext context, HomeTab activatedTab) {
        return BottomNavigationBar(
            currentIndex: HomeTab.values.indexOf(activatedTab),
            onTap: (int index) {
              HomeTab newTab = HomeTab.values[index];
              _tabsBloc.dispatch(UpdateTab(tab: newTab));
            },
            items: HomeTab.values.map((tab) {
              return BottomNavigationBarItem(
                  icon: Icon(
                    (tab == HomeTab.todos) ? Icons.add : Icons.menu,
                  ),
                  title: (tab == HomeTab.todos) ? Text("Todos") : Text("Stat"));
            }).toList());
      },
    );
  }
}
