import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveTestPage extends StatefulWidget {
  const ResponsiveTestPage({Key? key}) : super(key: key);

  @override
  State<ResponsiveTestPage> createState() => _ResponsiveTestPageState();
}

class _ResponsiveTestPageState extends State<ResponsiveTestPage> {
  List _colors = [];
  int _elementCount = 3;

  @override
  void initState() {
    super.initState();
    _colors = getRandomColors(3);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Wrap(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(hintText: 'N° of elements'),
                    onChanged: (value) {
                      print('VALUE $value');
                      if (value.length == 0) {
                        return null;
                      }
                      var intValue = value.length > 0 ? int.parse(value) : 0;
                      setState(() {
                        _colors = getRandomColors(intValue);
                        _elementCount = intValue;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black26,
              height: 500,
              child: ResponsiveRowColumn(
                  layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  rowCrossAxisAlignment: CrossAxisAlignment.stretch,
                  columnMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  columnCrossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < _elementCount; i++)
                      ResponsiveRowColumnItem(
                        columnFlex: 1,
                        rowFlex: 1,
                        child: Container(
                          height: 50,
                          color: _colors[i],
                          child: Center(
                              child: Container(child: Text('Element $i'))),
                        ),
                      ),
                  ]),
            ),
          ],
        )
      ],
    );
  }

  getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  getRandomColors(int) {
    var colors = [];
    for (var i = 0; i < int; i++) {
      colors.add(getRandomColor());
    }
    return colors;
  }
}
