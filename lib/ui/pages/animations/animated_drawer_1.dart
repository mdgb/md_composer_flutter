import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/gallery_page.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/posts_page.dart';
import 'package:md_composer_flutter/ui/widget_library/drawers/drawer_expandable/drawer_expandable.dart';

class AnimatedDrawer1 extends ConsumerStatefulWidget {
  const AnimatedDrawer1({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedDrawer1State();
}

class _AnimatedDrawer1State extends ConsumerState<AnimatedDrawer1>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  _toggleDrawer() {
    print('OPEN DRAWER ${_animationController.isDismissed}');
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  double maxSlide = 200;

  double minDragStartEdge = 30;
  double maxDragStartEdge = 100;
  bool _canBeDragged = true;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged && details.primaryDelta != null) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  close() {
    _animationController.reverse();
  }

  open() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, Widget? child) {
        double scale = 1 - (_animationController.value * 0.2);
        double rotateY = 0 + (_animationController.value * 0.01);
        double translationValuesX = maxSlide * _animationController.value;
        double translationValuesY = MediaQuery.of(context).size.height *
            0.1 *
            _animationController.value;

        return GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _toggleDrawer();
                },
                child: Row(
                  children: [
                    Container(
                      // width: double.infinity,
                      // color: Color.fromARGB(255, 13, 45, 77),
                      child: const DrawerExpandableComponent(),
                    ),
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 16, 62, 108),
                      ),
                    )
                  ],
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    translationValuesX, translationValuesY, 0)
                  ..scale(scale)
                  ..setEntry(3, 2, 0.02)
                  ..rotateY(rotateY),
                child: Scaffold(
                  appBar: AppBar(
                    leading: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _toggleDrawer();
                        },
                        child: const Icon(Icons.menu_outlined),
                      ),
                    ),
                    title: const Text('Animated Drawer'),
                  ),
                  body: Container(
                    child: Posts(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
