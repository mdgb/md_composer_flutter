import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:md_composer_flutter/ui/widget_library/avatars/avatar_base/avatar_base.dart';

import 'cdm.dart' show CDM;

class DrawerExpandableComponent extends ConsumerStatefulWidget {
  const DrawerExpandableComponent({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DrawerExpandableComponentState();
}

class _DrawerExpandableComponentState
    extends ConsumerState<DrawerExpandableComponent> {
  int depth = 0;
  int selectedIndex = -1;
  String selectedPath = '';
  Color textColor = Colors.white;
  double drawerWidth = 200;

  List menuItems = [];

  _DrawerExpandableComponentState() {
    List<CDM> items = [
      const CDM(
          title: 'Home', icon: Icons.subscriptions, url: '/home', submenus: []),
      const CDM(
          title: 'Splash', icon: Icons.subscriptions, url: '/', submenus: []),
      const CDM(
          title: 'Responsive page',
          icon: Icons.subscriptions,
          url: '/responsive_page',
          submenus: []),
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
      CDM(title: 'Auth', icon: Icons.person, submenus: [
        CDM(title: 'Login', icon: null, url: '/login', submenus: []),
        CDM(
            title: 'Logout',
            icon: null,
            // url: '/logout',
            submenus: [],
            action: () async {
              print('LOGOUT ACTION');
              var auth = ref.read(authViewModelProvider.notifier);
              await auth.logout();
              context.go('/');
            }),
        CDM(title: 'Register', icon: null, url: '/register', submenus: []),
        CDM(
            title: 'Reset Password',
            icon: null,
            url: '/resetpassword',
            submenus: []),
      ]),
      const CDM(
          title: 'Typography', icon: Icons.font_download, url: '/typography'),
      const CDM(title: 'Forms', icon: Icons.input, url: '/forms'),
      const CDM(
        title: 'Factory Tests',
        icon: Icons.account_tree_outlined,
        submenus: [
          CDM(
            title: 'Static Factory',
            icon: Icons.account_tree_outlined,
            url: '/factory',
          ),
          CDM(
            title: 'Json Dynamic Widget',
            icon: Icons.account_tree_outlined,
            url: '/json_dynamic_widget',
          ),
        ],
      ),
      const CDM(title: 'Slivers', icon: Icons.arrow_downward, submenus: [
        CDM(
            title: 'Sticky box',
            icon: Icons.explore,
            submenus: [],
            url: '/sticky_box'),
      ]),
      const CDM(title: 'API Contents', icon: Icons.api, submenus: [
        CDM(
            title: 'Posts',
            icon: Icons.text_fields_outlined,
            submenus: [],
            url: '/posts'),
        CDM(
            title: 'Gallery',
            icon: Icons.text_fields_outlined,
            submenus: [],
            url: '/gallery'),
      ]),
      const CDM(title: 'Animations', icon: Icons.animation, submenus: [
        CDM(
            title: 'Animated Drawer 1',
            icon: Icons.draw,
            submenus: [],
            url: '/animated_drawer_1'),
        CDM(
            title: 'Animated Carousel',
            icon: Icons.draw,
            submenus: [],
            url: '/animated_carousel_1'),
        CDM(
            title: 'Glass Effect',
            icon: Icons.draw,
            submenus: [],
            url: '/glass_effect'),
      ]),
      CDM(
          title: 'Settings',
          icon: Icons.settings,
          action: () async {
            Scaffold.of(context).openEndDrawer();
          }),
    ];
    menuItems.addAll(items);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: 200,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Container(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              FlutterLogo(size: 36),
                            ],
                          ),
                          Container(child: AvatarBase()),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
            ),
          )
        ],
      ),
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
          child: Material(
            color: Colors.transparent,
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
                          Icon(
                            item.icon,
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                          ),
                          SizedBox(width: 8),
                          Text(
                            item.title,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface),
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
                  if (item.action != null) {
                    print('EXECUTE ACTION');
                    item.action!();
                  }
                  if (item.url != null) {
                    GoRouter.of(context).go(item.url.toString());
                  }
                }),
          ),
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
