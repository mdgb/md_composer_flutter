///HOMEPAGE MENE YAHA PAR HE BOTTOMNAVIGATION USE KIYA HAI
///KYUNKI CODE CHHOTA HAI ISLIYE
import 'package:flutter/material.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/providers/drawer_menu_provider.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedDestination = ref.watch(selectedDrawerMenuProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    selectDestination(String location) {
      ref.read(selectedDrawerMenuProvider.notifier).state = location;
      context.go(location);
    }

    return ListView(
      controller: ScrollController(),
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: BackgroundClipper(),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
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
                      const SizedBox(height: 40)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: Center(
            child: Container(
              width: 400,
              height: 400,
              child: const Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1657564793579-9d49d4d7257b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              ),
              transform: Matrix4.translationValues(0.0, -150.0, 0.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Ehia!!!')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Eeeehiaaaaa!!!')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Eeeehia!!!')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 250,
        )
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
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
