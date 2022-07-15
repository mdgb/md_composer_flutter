import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
