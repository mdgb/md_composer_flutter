///HOMEPAGE MENE YAHA PAR HE BOTTOMNAVIGATION USE KIYA HAI
///KYUNKI CODE CHHOTA HAI ISLIYE
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/providers/drawer_menu_provider.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedDestination = ref.watch(selectedDrawerMenuProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListView(
      controller: ScrollController(),
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              bottom: 150,
              child: ClipPath(
                clipper: BackgroundClipper1(),
                child: Container(
                  width: double.infinity,
                  // height: double.minPositive,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 2, 22, 40),
                        Color.fromARGB(255, 61, 18, 15),
                      ],
                    ),
                  ),
                  child: Container(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Barra Menu',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: const Text(
                      'Titolo Big !',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: const Text(
                      'Powerful and professional admin template for Web Applications, CRM, CMS, Admin Panels and more..',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 80),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: ResponsiveValue(
                      context,
                      defaultValue: 400.0,
                      valueWhen: [
                        Condition.smallerThan(name: MOBILE, value: 300.0),
                        Condition.largerThan(
                            name: TABLET,
                            value: MediaQuery.of(context).size.width / 2),
                        Condition.largerThan(
                            name: DESKTOP,
                            value: MediaQuery.of(context).size.width / 3),
                      ],
                    ).value,
                    child: const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1657564793579-9d49d4d7257b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                    ),
                    // transform: Matrix4.translationValues(0.0, -150.0, 0.0),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            spreadRadius: 20,
                            blurRadius: 0,
                            offset: const Offset(0, -3),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            spreadRadius: 40,
                            blurRadius: 0,
                            offset: const Offset(0, -3),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            spreadRadius: 60,
                            blurRadius: 0,
                            offset: const Offset(0, -3),
                          ),
                        ]),
                  ),
                  // const SizedBox(height: 40)
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          // transform: Matrix4.translationValues(0.0, -150.0, 0.0),
          child: Column(
            children: [
              Center(
                child: Text('Lorem ipsum dolor sit amet...',
                    style: TextStyle(fontSize: 24)),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
          color: Colors.blue.shade900,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Looking for something cool ?',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ResponsiveRowColumn(
                  layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Text('Ehia!!!')),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Text('Eeeehiaaaaa!!!')),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Text('Eeeehia!!!')),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Positioned.fill(
              child: ClipPath(
                clipper: BackgroundClipper2(),
                child: Container(
                  width: double.infinity,
                  // height: double.minPositive,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(248, 250, 252, 0),
                        Color.fromRGBO(226, 232, 240, 100),
                      ],
                    ),
                  ),
                  child: Container(),
                ),
              ),
            ),
            Container(
              child: ResponsiveRowColumn(
                rowMainAxisAlignment: MainAxisAlignment.center,
                layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: Container(
                      padding: EdgeInsets.all(32),
                      // color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 80, height: 80, child: Placeholder()),
                          MarkdownBody(
                            data: markdownContent,
                            onTapLink: (text, href, title) {
                              print('HREF $text, $href, $title');
                              href != null ? launchUrl(Uri.parse(href)) : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: Placeholder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40)
      ],
    );
  }
}

class BackgroundClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height - 150,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BackgroundClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height + 150,
      size.width,
      size.height - 150,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
