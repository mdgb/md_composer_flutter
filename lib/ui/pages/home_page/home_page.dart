import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/providers/drawer_menu_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/pages/home_page/home_provider.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box1.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box2.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box3.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box4.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box5.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/box6.dart';
import 'package:md_composer_flutter/ui/pages/home_page/partials/intro.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String markdownContent = '''
# Heading h1
## Heading h2
###### Heading h6

Lorem ipsum **bold text** [Link](https://flutter.dev)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
''';

  static const String markdownContent2 = '''
  # Fuse is a learning source
  With well commented and structured source code, whether a beginner or a seasoned React developer, you will find something interesting in Fuse React.
''';

  static const String markdownContent3 = ''' 
  It's always a burden to create different layouts for different areas of an app.
Fuse React makes this easier with built in layout management and allows for different layouts for different pages/routes.
This makes extremely easy to create and have simple and complex layouts together like a Login page or a Mail app.
Page/route based Color management and theme configuration compatible with Material UI Next.
  ''';

  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedDestination = ref.watch(selectedDrawerMenuProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final _scrollController = ScrollController();
    return NotificationListener(
      onNotification: (e) {
        // print(_scrollController.position.pixels);
        ref.read(scrollProvider.notifier).state =
            _scrollController.position.pixels;
        return false;
      },
      child: ListView(
        controller: _scrollController,
        children: [
          Intro(colorScheme: colorScheme),
          box1(),
          box2(colorScheme: colorScheme),
          box3(colorScheme: colorScheme, markdownContent: markdownContent),
          const SizedBox(height: 40),
          box4(colorScheme: colorScheme, markdownContent2: markdownContent2),
          const SizedBox(height: 40),
          box5(colorScheme: colorScheme, markdownContent3: markdownContent3),
          const SizedBox(height: 40),
          box6(colorScheme: colorScheme),
          SizedBox(height: 800),
        ],
      ),
    );
  }
}
