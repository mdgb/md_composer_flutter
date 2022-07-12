import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/widget_library/drawers/drawer_expandable/drawer_expandable.dart';

class BaseTemplate extends ConsumerWidget {
  final Widget page;
  final String pageTitle;

  BaseTemplate({Key? key, required this.page, this.pageTitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double pageWidth = MediaQuery.of(context).size.width;
    bool isMobileResolution = pageWidth < 800;

    return Scaffold(
      appBar: isMobileResolution
          ? AppBar(
              title: Text(pageTitle),
            )
          : null,
      // drawerScrimColor: Colors.transparent,
      drawer: isMobileResolution ? DrawerExpandableComponent() : null,
      body: Container(child: getBodyLayout(isMobileResolution)),
    );
  }

  getBodyLayout(isMobileResolution) {
    if (isMobileResolution == true) {
      return ListView(controller: ScrollController(), children: [page]);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            height: double.infinity,
            child: DrawerExpandableComponent(),
          ),
          Expanded(
            child: page,
          )
        ],
      );
    }
  }
}
