import 'package:mobx/mobx.dart';

part '../counter.g.dart';

// NOTE: The generated file that must accompany this needs to be generated using the MobX code-gen package, and has NOT been provided

class CounterStore = _CounterStore with _$CounterStore;

abstract class _CounterStore with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  void init() {
    //Add initialization code here
  }
  void dispose() {
    //Add cleanup code here
  }
}
