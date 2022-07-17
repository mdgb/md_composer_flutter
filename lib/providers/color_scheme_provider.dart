import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorSchemeProvider = StateProvider(
  (ref) =>
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 38, 255)),
);
