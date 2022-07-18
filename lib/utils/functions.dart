import 'dart:math';

import 'package:flutter/material.dart';

getRandomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

String capitalize(String s) =>
    s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';
