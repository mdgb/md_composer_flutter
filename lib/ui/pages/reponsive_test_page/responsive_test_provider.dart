import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorsProvider = StateProvider<List<MaterialColor>>((ref) => [
      Colors.primaries[1],
      Colors.primaries[4],
      Colors.primaries[7],
    ]);
final elementCountProvider = StateProvider((ref) => 3);
final exampleProvider = StateProvider((ref) => 'ResponsiveRowColumn');
