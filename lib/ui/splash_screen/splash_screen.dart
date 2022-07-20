import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:md_composer_flutter/providers/cache_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/services/auth_services.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String route = "/splash";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var auth = ref.read(authViewModelProvider.notifier);
      var currentUser = auth.user;

      Future.delayed(const Duration(seconds: 3)).whenComplete(() {
        if (currentUser != null) {
          context.go('/home');
        } else {
          context.go('/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    return Scaffold(
        backgroundColor: scheme.primaryContainer,
        body: Center(
          child: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              // color: Colors.white,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: MyStatefulWidget(),
                      ),

                      // const SizedBox(
                      //   width: 120,
                      //   height: 120,
                      //   child: CircularProgressIndicator(
                      //     backgroundColor: Color.fromARGB(221, 226, 52, 8),
                      //   ),
                      // ),
                      Text(
                        'My App',
                        style: styles.headlineLarge!
                            .copyWith(color: scheme.onPrimaryContainer),
                      ),
                    ]),
              )),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward(); //..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
