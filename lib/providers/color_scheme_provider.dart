import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorSchemeProvider = Provider(
  (ref) => ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 33, 24, 98)),
);
