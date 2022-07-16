import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/examples/grid_view_example.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/examples/responsive_row_column.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/examples/staggered_gridcounte_example.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/examples/wrap_example.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/responsive_test_provider.dart';

class ResponsiveTestPage extends ConsumerWidget {
  final examples = const <String>[
    'ResponsiveRowColumn',
    'Wrap',
    'GridView',
    'StaggeredGridView'
  ];

  const ResponsiveTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _elementCount = ref.watch(elementCountProvider);
    final _colors = ref.watch(colorsProvider);
    final _example = ref.watch(exampleProvider);

    return Scaffold(
      body: ListView(
        controller: ScrollController(),
        children: [
          if (_example == 'ResponsiveRowColumn')
            ResponsiveRowColumnExample(
                elementCount: _elementCount, colors: _colors),
          if (_example == 'Wrap')
            WrapExample(elementCount: _elementCount, colors: _colors),
          if (_example == 'GridView')
            GridViewExample(elementCount: _elementCount, colors: _colors),
          if (_example == 'StaggeredGridView')
            StaggeredGridCountExample(
                elementCount: _elementCount, colors: _colors),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 800,
                          child: ExamplesFormController(ref, _example),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        label: const Text('Settings'),
        icon: const Icon(Icons.settings),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        foregroundColor: Colors.white,
      ),
    );
  }

  Container ExamplesFormController(WidgetRef ref, String _example) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              decoration: const InputDecoration(hintText: 'N° of elements'),
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                var intValue = value.isNotEmpty ? int.parse(value) : 0;
                ref.read(colorsProvider.notifier).state =
                    getRandomColors(intValue);
                ref.read(elementCountProvider.notifier).state = intValue;
              },
            ),
          ),
          Container(
            child: DropdownButton(
              value: _example,
              items: examples.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                ref.read(exampleProvider.notifier).state = value.toString();
              },
            ),
          ),
        ],
      ),
    );
  }

  getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  getRandomColors(int) {
    List<MaterialColor> colors = [];
    for (var i = 0; i < int; i++) {
      colors.add(getRandomColor());
    }
    return colors;
  }
}
