import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/responsive_test_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          formController(ref, _example),
          Divider(height: 2),
          SizedBox(height: 20),
          if (_example == 'ResponsiveRowColumn')
            responsiveRowColumn(context, _elementCount, _colors),
          if (_example == 'Wrap')
            WrapExample(elementCount: _elementCount, colors: _colors),
          if (_example == 'GridView')
            gridViewExample(elementCount: _elementCount, colors: _colors),
          if (_example == 'StaggeredGridView')
            staggeredGridCountExample(
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
                // height: 200,
                color: Colors.transparent,

                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        right: 0,
                        width: 100,
                        child: ElevatedButton(
                          child: const Text('Close BottomSheet'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text('Modal BottomSheet'),
                    ],
                  ),
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

  ResponsiveRowColumn responsiveRowColumn(
      BuildContext context, int _elementCount, List<MaterialColor> _colors) {
    return ResponsiveRowColumn(
      layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      // rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      columnMainAxisAlignment: MainAxisAlignment.start,
      columnVerticalDirection: VerticalDirection.down,

      // columnCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        _elementCount,
        (i) => ResponsiveRowColumnItem(
          key: Key(i.toString()),
          rowFlex: 1,
          child: Container(
            padding: EdgeInsets.all(5.0),
            color: _colors[i],
            child: Center(
              child: Text('Element $i'),
            ),
          ),
        ),
      ),
    );
  }

  Container formController(WidgetRef ref, String _example) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          TextField(
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
          DropdownButton(
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
          )
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

class staggeredGridCountExample extends StatelessWidget {
  const staggeredGridCountExample({
    Key? key,
    required int elementCount,
    required List<MaterialColor> colors,
  })  : _elementCount = elementCount,
        _colors = colors,
        super(key: key);

  final int _elementCount;
  final List<MaterialColor> _colors;

  @override
  Widget build(BuildContext context) {
    final h_axisCount =
        ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? 2 : 8;
    List<int> hSizes = generateRandomNumbersToSum(_elementCount, h_axisCount);
    return StaggeredGrid.count(
      crossAxisCount: h_axisCount,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        for (var i = 0; i < _elementCount; i++)
          StaggeredGridTile.count(
            crossAxisCellCount: hSizes[i],
            mainAxisCellCount: 1,
            child: Container(
              color: _colors[i],
              child: Center(child: Text('Element $i')),
            ),
          )
      ],
    );
  }

  int randombetween(int min, int max) {
    return Random().nextInt(max) + min;
  }

  generateRandomNumbersToSum(int elementCount, int h_axisCount) {
    print('generateRandomNumbersToSum $elementCount , $h_axisCount');
    int remainingRows = elementCount;
    List<int> sizes = [];
    for (var c = 0; c < elementCount; c++) {
      if (remainingRows <= 0) {
        return sizes;
      }
      int elementsInRow = Random().nextInt(h_axisCount) + 1;
      remainingRows = remainingRows - elementsInRow;
      print('elementsInRow $elementsInRow');
      var r = <int>[];
      var currsum = 0;
      for (var i = 0; i < elementsInRow - 1; i++) {
        int newRandom =
            randombetween(1, h_axisCount - (elementsInRow - i - 1) - currsum);
        print('newRandom $newRandom');
        r.add(newRandom);
        currsum = currsum + r[i];
      }
      r.add(h_axisCount - currsum);
      print('RRR $r');
      sizes.addAll(r);
    }

    return sizes;
  }
}

class gridViewExample extends StatelessWidget {
  const gridViewExample({
    Key? key,
    required int elementCount,
    required List<MaterialColor> colors,
  })  : _elementCount = elementCount,
        _colors = colors,
        super(key: key);

  final int _elementCount;
  final List<MaterialColor> _colors;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _elementCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? 2 : 8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 16 / 9,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: _colors[index],
          child: Center(child: Text('Element $index')),
        );
      },
    );
  }
}

class WrapExample extends StatelessWidget {
  const WrapExample({
    Key? key,
    required int elementCount,
    required List<MaterialColor> colors,
  })  : _elementCount = elementCount,
        _colors = colors,
        super(key: key);

  final int _elementCount;
  final List<MaterialColor> _colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        // runSpacing: 5,
        // spacing: 5,
        children: [
          for (var i = 0; i < _elementCount; i++)
            LayoutBuilder(
              builder: ((context, constraints) => Container(
                    width: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                        ? constraints.maxWidth / 2
                        : constraints.maxWidth / 8,
                    color: _colors[i],
                    padding: EdgeInsets.all(24),
                    child: Text('Element $i'),
                  )),
            ),
        ],
      ),
    );
  }
}
