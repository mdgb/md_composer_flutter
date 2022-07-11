import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/widget_library/drawers/drawer_expandable/drawer_expandable.dart';

class BaseTemplate extends ConsumerWidget {
  final Widget page;
  final String pageTitle;

  const BaseTemplate({Key? key, required this.page, this.pageTitle = ' '})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      drawer: DrawerExpandableComponent(),
      body: page,
    );
  }
}
