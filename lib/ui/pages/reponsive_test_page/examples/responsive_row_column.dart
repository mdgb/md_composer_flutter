import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveRowColumnExample extends StatelessWidget {
  const ResponsiveRowColumnExample({
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
}
