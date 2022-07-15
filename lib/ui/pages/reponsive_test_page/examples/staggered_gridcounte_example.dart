import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StaggeredGridCountExample extends StatelessWidget {
  const StaggeredGridCountExample({
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
