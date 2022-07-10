import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/widget_library/drawers/drawer_expandable/drawer_expandable.dart';

class BaseTemplate extends ConsumerWidget {
  final Widget page;

  const BaseTemplate({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerExpandableComponent(),
      body: page,
    );
  }
}
