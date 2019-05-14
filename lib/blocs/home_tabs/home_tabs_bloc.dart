import 'dart:async';
import 'package:bloc/bloc.dart';
import 'index.dart';

class HomeTabsBloc extends Bloc<HomeTabsEvent, HomeTab> {
  @override
  HomeTab get initialState => HomeTab.todos;

  @override
  Stream<HomeTab> mapEventToState(
    HomeTabsEvent event,
  ) async* {
    if(event is UpdateTab) {
      yield event.tab;
    }
  }
}
