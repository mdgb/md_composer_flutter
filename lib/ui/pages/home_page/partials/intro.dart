import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Intro extends StatefulWidget {
  const Intro({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          bottom: 150,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              final milliseconds = _controller.value;
              return ClipPath(
                clipper: BackgroundClipper1(seconds: milliseconds),
                child: Container(
                  width: double.infinity,
                  // height: double.minPositive,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        widget.colorScheme.primary,
                        widget.colorScheme.onBackground,
                      ],
                    ),
                  ),
                  child: Container(),
                ),
              );
            },
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
              const SizedBox(height: 80),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: ResponsiveValue(
                  context,
                  defaultValue: 400.0,
                  valueWhen: [
                    const Condition.smallerThan(name: MOBILE, value: 300.0),
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
    );
  }
}

class BackgroundClipper1 extends CustomClipper<Path> {
  double seconds = 0;
  BackgroundClipper1({Key? key, required this.seconds});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * seconds,
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
    // print(seconds);
    return true;
  }
}
