import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';

class SettingsPanel extends ConsumerWidget {
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);
    return Container(
        padding: EdgeInsets.all(16),
        width: 250,
        color: colorScheme.background,
        child: Column(
          children: [
            Text('Pick a color!'),
            Divider(color: Colors.transparent),
            MaterialPicker(
              pickerColor: colorScheme.primary,
              onColorChanged: (color) {
                ref.read(colorSchemeProvider.notifier).state =
                    ColorScheme.fromSeed(seedColor: color);
                return null;
              },
            ),
          ],
        ));
  }
}
