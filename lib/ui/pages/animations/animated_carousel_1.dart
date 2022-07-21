import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AnimatedCarousel extends StatefulWidget {
  const AnimatedCarousel({Key? key}) : super(key: key);

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  final data = [
    'https://cdn.dribbble.com/userupload/3146591/file/original-3906bfdce50fe4563057195f3b062ebb.jpg?compress=1&resize=752x564&vertical=center',
    'https://cdn.dribbble.com/userupload/3146426/file/original-487566ed1ad7fd197e57749c119ec0a9.jpg?compress=1&resize=1024x768',
    'https://cdn.dribbble.com/users/1803663/screenshots/16559737/media/3089be1dbc25bfeec57778f648e80df4.png?compress=1&resize=1000x750&vertical=top',
    'https://cdn.dribbble.com/users/1803663/screenshots/16540628/media/1bcb54effbede71a5997e39ddcdd7bfa.png?compress=1&resize=1000x750&vertical=top',
    'https://cdn.dribbble.com/users/1714897/screenshots/18053004/media/d7084f0337a668d6117b875047ce0546.png?compress=1&resize=800x600&vertical=top',
    'https://cdn.dribbble.com/users/1714897/screenshots/18053004/media/2b356e7b4ce601361a8e4a4fb7242e63.png?compress=1&resize=1000x750&vertical=top',
    'https://cdn.dribbble.com/users/10759667/screenshots/18019192/media/21354c4066e15727b6e2eeaccc8c89d4.png?compress=1&resize=1000x750&vertical=top',
  ];

  double viewportFraction = 1;

  final controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final initialPage = 0;
  int _currentPage = 0;
  _gotoPage(page) {
    controller.animateToPage(
      page,
      duration: Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (keyEvent) {
        if (keyEvent.logicalKey.keyLabel == 'Arrow Right') {
          if (_currentPage < data.length) {
            _gotoPage(_currentPage + 1);
          }
        }
        if (keyEvent.logicalKey.keyLabel == 'Arrow Left') {
          if (_currentPage >= 0) {
            _gotoPage(_currentPage - 1);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                GoRouter.of(context).go('/home');
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          title: const Text('Animated Drawer'),
        ),
        body: PageView.builder(
          controller: controller,
          scrollDirection: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              ? Axis.horizontal
              : Axis.vertical,
          pageSnapping: true,
          onPageChanged: (page) {
            setState(() {
              print('CURRENT PAGE: $page');
              _currentPage = page;
            });
          },
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 0.9,
                  widthFactor: 0.9,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(data[index]),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
