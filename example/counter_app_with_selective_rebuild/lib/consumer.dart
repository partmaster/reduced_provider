// consumer.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_provider/reduced_provider.dart';

import 'props.dart';
import 'mapper.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => ReducedConsumer(
        mapper: MyHomePagePropsMapper.new,
        builder: builder,
      );
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => ReducedConsumer(
        mapper: MyCounterWidgetPropsMapper.new,
        builder: builder,
      );
}
