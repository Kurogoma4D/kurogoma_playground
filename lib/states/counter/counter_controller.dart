import 'package:KRPG/states/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final counterControllerProvider =
    StateNotifierProvider<CounterController, Counter>(
        (_) => CounterController());

class CounterController extends StateNotifier<Counter> {
  CounterController() : super(const Counter(count: 0));

  void increment() => state = state.copyWith(
        count: state.count + 1,
      );
}
