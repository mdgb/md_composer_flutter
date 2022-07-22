import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FactoryTestWidgets extends StatelessWidget {
  FactoryTestWidgets({Key? key}) : super(key: key);

  final List widgetList = [
    {
      'widgetName': 'widgetA',
      'props': {'text': 'Hello from First'}
    },
    {
      'widgetName': 'widgetA',
      'props': {'text': 'Hello from Second'}
    },
    {
      'widgetName': 'widgetA',
      'props': {'text': 'Hello from Third'}
    },
    {
      'widgetName': 'widgetB',
      // 'props': {'text': 'Hello from Third'}
    },
    {
      'widgetName': 'widgetC',
      // 'props': {'text': 'Hello from Third'}
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = widgetList
        .map((e) =>
            FactoryWidget(widgetName: e['widgetName'], props: e['props']))
        .toList();
    // FactoryWidget(widgetName: e.widgetName, props: e.props));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        direction: Axis.vertical,
        children: widgets,
      ),
    );
    // return FactoryWidget(widgetName: 'widgetA', props: {'text': 'Hello'});
  }
}

class FactoryWidget extends StatelessWidget {
  final Map? props;
  final String widgetName;

  const FactoryWidget({Key? key, required this.widgetName, this.props})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (widgetName == 'widgetA') return MyWidgetA(text: props?['text']);
    if (widgetName == 'widgetB') return MyWidgetB();
    if (widgetName == 'widgetC') return MyWidgetC();
    return Text('NO WIDGET FOUND');
  }
}

class MyWidgetA extends StatelessWidget {
  late String? text = '';

  MyWidgetA({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('WIDGET A: $text');
  }
}

class MyWidgetB extends StatelessWidget {
  const MyWidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('MyWidget B');
  }
}

class MyWidgetC extends StatelessWidget {
  const MyWidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('MyWidget C  $context');
  }
}
