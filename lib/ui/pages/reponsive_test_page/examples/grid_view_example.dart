import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GridViewExample extends StatelessWidget {
  const GridViewExample({
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
