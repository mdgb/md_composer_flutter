import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class box2 extends StatelessWidget {
  const box2({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
      color: colorScheme.primary,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Looking for something cool ?',
                  style: TextStyle(color: colorScheme.onPrimary, fontSize: 24),
                )
              ],
            ),
            const SizedBox(height: 20),
            ResponsiveRowColumn(
              layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowMainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: colorScheme.onPrimaryContainer,
                          primary: colorScheme.inversePrimary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: const Text('Ehia!!!')),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: colorScheme.onPrimaryContainer,
                          primary: colorScheme.inversePrimary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: const Text('Eeeehiaaaaa!!!')),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: colorScheme.onPrimaryContainer,
                          primary: colorScheme.inversePrimary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: const Text('Eeeehia!!!')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
