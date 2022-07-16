import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/ui/widget_library/drawers/drawer_expandable/drawer_expandable.dart';
import 'package:md_composer_flutter/ui/widget_library/settings_panel/settings_panel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BaseTemplate extends ConsumerWidget {
  final Widget page;
  final String pageTitle;

  BaseTemplate({Key? key, required this.page, this.pageTitle = ''})
      : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? AppBar(
              title: Text(pageTitle),
            )
          : null,
      // drawerScrimColor: Colors.transparent,
      drawer: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? DrawerExpandableComponent()
          : null,
      body: getBodyLayout(context, page),
      endDrawer: SettingsPanel(),
    );
  }

  getBodyLayout(context, page) {
    if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return page;
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
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
