![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced_provider)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced_provider/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced_provider)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced_provider)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced_provider)
# reduced_provider

Implementation of the 'reduced' API for the 'Provider' state management framework with following features:

1. Implementation of the ```Reducible``` interface 
2. Register a state for management.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Reducible``` interface 

```dart
extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) => value = reducer(value);

  Reducible<S> get reducible =>
      ReducibleProxy(getState, reduce, this);
}
```

#### 2. Register a state for management.

```dart
Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    ChangeNotifierProvider<ValueNotifier<S>>(
      create: (context) => ValueNotifier<S>(initialState),
      child: child,
    );
```

#### 3. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer<S, P>({
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    Selector<ValueNotifier<S>, P>(
      builder: (context, props, _) => builder(props: props),
      selector: (context, notifier) =>
          transformer(notifier.reducible),
    );
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package 'reduced_provider'.

```
dependencies:
  reduced: ^0.1.0
  reduced_provider: ^0.1.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_provider/reduced_provider.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counterText, required this.onPressed});
  final String counterText;
  final Callable<void> onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: CallableAdapter(reducible, Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: const Text('reduced_provider example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(props.counterText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
```

Finished counter demo app using logic.dart and 'reduced_provider' package:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_provider/reduced_provider.dart';
import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => wrapWithProvider(
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) => wrapWithConsumer(
              transformer: transformer,
              builder: builder,
            ),
          ),
        ),
      );
}
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Binder](https://pub.dev/packages/binder)|[reduced_binder](https://github.com/partmaster/reduced_binder)|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[FlutterCommand](https://pub.dev/packages/flutter_command)|[reduced_fluttercommand](https://github.com/partmaster/reduced_fluttercommand)|
|[FlutterTriple](https://pub.dev/packages/flutter_triple)|[reduced_fluttertriple](https://github.com/partmaster/reduced_fluttertriple)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[MobX](https://pub.dev/packages/mobx)|[reduced_mobx](https://github.com/partmaster/reduced_mobx)|
|[Provider](https://pub.dev/packages/provider)|[reduced_provider](https://github.com/partmaster/reduced_provider)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
|[Solidart](https://pub.dev/packages/solidart)|[reduced_solidart](https://github.com/partmaster/reduced_solidart)|
|[StatesRebuilder](https://pub.dev/packages/states_rebuilder)|[reduced_statesrebuilder](https://github.com/partmaster/reduced_statesrebuilder)|
