import 'dart:math';

import 'package:flutter/material.dart';

getRandomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
