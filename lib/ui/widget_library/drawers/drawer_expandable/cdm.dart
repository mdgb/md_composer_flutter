import 'package:flutter/material.dart';

class CDM {
  final String title;
  final IconData? icon;
  final String? url;
  final List<CDM> submenus;
  const CDM(
      {required this.title, this.icon, this.url, this.submenus = const []});
}
