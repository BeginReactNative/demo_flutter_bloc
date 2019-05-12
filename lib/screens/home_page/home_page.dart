import 'package:bloc/bloc.dart';
import 'package:bloc_partten/screens/home_page/counter_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum CounterEvent { increment, decrement }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterBloc _counterBloc = CounterBloc();
  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: _counterBloc,
      child: CounterPage()
    );
  }
}

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
        print("current State ---" + currentState.toString());
    print("event---" + event.toString());
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      default:
        yield currentState;
    }
  }
}
