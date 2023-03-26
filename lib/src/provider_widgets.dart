// provider_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reduced/reduced.dart';

import 'provider_store.dart';

class ReducedProvider<S> extends StatelessWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    required this.child,
  });

  final S initialState;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ValueNotifier<S>>(
        create: (context) => ValueNotifier<S>(initialState),
        child: child,
      );
}

class ReducedConsumer<S, P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.mapper,
    required this.builder,
  });

  final StateToPropsMapper<S, P> mapper;
  final WidgetFromPropsBuilder<P> builder;

  @override
  Widget build(BuildContext context) => Selector<ValueNotifier<S>, P>(
        builder: (context, props, _) => builder(props: props),
        selector: (context, notifier) => mapper(
          notifier.getState(),
          notifier.proxy,
        ),
      );
}
