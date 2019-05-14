import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class HomeTabsEvent extends Equatable {
  HomeTabsEvent([List props = const []]) : super(props);
}
class UpdateTab extends HomeTabsEvent {
  final HomeTab tab;
  UpdateTab({this.tab}) : super([tab]);
  @override
  String toString() {
    return 'Update Tab: $tab';
  }
}