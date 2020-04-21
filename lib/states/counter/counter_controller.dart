
import 'package:KRPG/states/counter/counter.dart';
import 'package:state_notifier/state_notifier.dart';

class CounterController extends StateNotifier<Counter> {
  CounterController() : super(const Counter(count: 0));

  void increment() => state = state.copyWith(
    count: state.count + 1,
  );
}