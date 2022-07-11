import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'cdm.dart' show CDM;

class DrawerExpandableComponent extends StatefulWidget {
  const DrawerExpandableComponent({Key? key}) : super(key: key);

  @override
  State<DrawerExpandableComponent> createState() =>
      _DrawerExpandableComponentState();
}

class _DrawerExpandableComponentState extends State<DrawerExpandableComponent> {
  int depth = 0;
  int selectedIndex = -1;
  String selectedPath = '';
  Color primaryColor = Color.fromARGB(255, 10, 50, 110);
  Color textColor = Colors.white;
  double drawerWidth = 200;

  List<CDM> menuItems = [
    const CDM(title: 'Dashboard', icon: Icons.grid_view, submenus: [
      CDM(title: 'Dash 1', icon: null, submenus: []),
      CDM(title: 'Dash 2', icon: Icons.grid_view, submenus: [
        CDM(title: 'Dash 2 - 1', icon: null, submenus: []),
        CDM(title: 'Dash 2 - 2', icon: null, submenus: []),
      ]),
    ]),
    const CDM(
        title: 'Welcome',
        icon: Icons.subscriptions,
        url: '/welcome',
        submenus: []),
    const CDM(title: 'XXX', icon: Icons.markunread_mailbox, submenus: []),
    const CDM(title: 'PIE', icon: Icons.pie_chart, submenus: [
      CDM(title: 'PIE 1', icon: Icons.pie_chart, submenus: []),
    ]),
    const CDM(title: 'XXX', icon: Icons.power, submenus: []),
    const CDM(title: 'XXX', icon: Icons.explore, submenus: []),
    const CDM(title: 'XXX', icon: Icons.settings, submenus: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
          backgroundColor: primaryColor,
          width: drawerWidth,
          child: Container(
            child: ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Container(
                    child: FlutterLogo(),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final CDM menuItem = menuItems[index];
                    return MenuItem(context, menuItem, index, depth, [index]);
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget MenuItem(context, CDM item, int index, int depth, originPath) {
    // print(
    // 'ITEM ${item.title} hasSubmenuItems ${item.submenus.length} depth $depth originPath: $originPath');
    final path = new List.from(originPath).join().toString();
    final isSelected = (path == selectedPath) | selectedPath.startsWith(path);
    // print('path $path | selectedPath ${selectedPath}');

    return Column(
      children: [
        Container(
          width: drawerWidth,
          child: InkWell(
              child: Container(
                padding: EdgeInsets.only(
                    top: 4, right: 4, bottom: 4, left: (8.0 * depth) + 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white10 : Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(item.icon, color: textColor),
                        SizedBox(width: 8),
                        Text(
                          item.title,
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                    if (item.submenus.length > 0) ...[
                      Icon(
                          isSelected
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: textColor)
                    ]
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  selectedPath == path
                      ? selectedPath = ''
                      : selectedPath = path;
                });
                if (item.url != null) {
                  GoRouter.of(context).go(item.url.toString());
                }
              }),
        ),
        Container(
          child:
              getSubmenu(context, item, index, depth, originPath, isSelected),
        )
      ],
    );
    // return Container(child: Text(item.title));
  }

  Widget? getSubmenu(context, CDM item, int index, int depth, List originPath,
      bool isSelected) {
    final bool hasSubmenu = item.submenus.isNotEmpty;
    final bool isValidSubmenu = hasSubmenu && isSelected;
    // TODO: check if parent is selected
    depth++;

    // print(
    //     '${item.title} hasSubmenu $hasSubmenu, isSelected $isSelected, isValidSubmenu $isValidSubmenu depth $depth');
    if (isValidSubmenu) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: item.submenus.length,
        itemBuilder: (BuildContext context, int index) {
          final CDM menuItem = item.submenus[index];
          if (originPath.length - 1 >= depth) {
            originPath[depth] = index;
          } else {
            originPath.add(index);
          }
          return MenuItem(context, menuItem, index, depth, originPath);
        },
      );
    }
  }
}

Widget itemIcon(CDM item, index) {
  if (item.icon != null) {
    return Icon(item.icon);
  } else {
    return Container();
  }
}
