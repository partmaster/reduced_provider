import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_provider/reduced_provider.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) {
    return state + 1;
  }
}

void main() {
  test('ValueNotifier state 0', () {
    final objectUnderTest = ValueNotifier(0).reducible;
    expect(objectUnderTest.state, 0);
  });

  test('ValueNotifier state 1', () {
    final objectUnderTest = ValueNotifier(1).reducible;
    expect(objectUnderTest.state, 1);
  });

  test('ValueNotifier reduce', () async {
    final objectUnderTest = ValueNotifier(0).reducible;
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });

  test('wrapWithConsumer', () {
    final objectUnderTest = wrapWithConsumer<int, int>(
      builder: ({Key? key, required int props}) => const SizedBox(),
      transformer: (reducible) => 1,
    );
    expect(objectUnderTest, isA<Selector<ValueNotifier<int>, int>>());
  });
}
