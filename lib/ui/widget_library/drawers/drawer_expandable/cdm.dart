import 'package:flutter/material.dart';

class CDM {
  final String title;
  final IconData? icon;
  final List<CDM> submenus;
  const CDM({required this.title, this.submenus = const [], this.icon});
}
