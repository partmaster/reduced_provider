// provider_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

/// Extension on class [ValueNotifier] with support of the [ReducedStore] interface.
extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) => value = reducer(value);

  ReducedStore<S> get reducible => ReducedStoreProxy(getState, reduce, this);
}
