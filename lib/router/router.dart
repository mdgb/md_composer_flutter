import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/reponsive_test_page.dart';
import 'package:md_composer_flutter/ui/splash_screen/splash_screen.dart';
import 'package:md_composer_flutter/utils/constants.dart';

import '../ui/pages/error_page/error_page.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/login_page/login_page.dart';
import '../ui/pages/register_page/register_page.dart';
import '../ui/pages/reset_password_page/reset_password_page.dart';
import '../ui/pages/welcome_page/welcome_page.dart';
import '../ui/templates/base_template.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
    refreshListenable: router,
    // redirect: router._redirectLogic,
    routes: router._routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {}

  List<GoRoute> get _routes => [
        GoRoute(
          name: rootRouteName,
          path: '/',
          // pageBuilder: (context, state) => MaterialPage<void>(
          //   key: state.pageKey,
          //   child: const SplashPage(),
          // ),
          redirect: (state) => state.namedLocation(homeRouteName),
        ),
        GoRoute(
          name: 'rootRouteName',
          path: '/root',
          redirect: (state) => state.namedLocation(homeRouteName),
        ),
        GoRoute(
          name: loginRouteName,
          path: '/login',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: LoginPage(),
          ),
        ),
        GoRoute(
          name: createAccountRouteName,
          path: '/register',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RegisterPage(),
          ),
        ),
        GoRoute(
          name: resetPasswordRouteName,
          path: '/resetpassword',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(
                page: ResetPasswordPage(), pageTitle: 'Reset password'),
          ),
        ),
        GoRoute(
          name: 'welcomeRouteName',
          path: '/welcome',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(page: const WelcomePage(), pageTitle: ''),
          ),
        ),
        GoRoute(
          name: homeRouteName,
          path: '/home',
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: BaseTemplate(page: const HomePage(), pageTitle: 'Home'),
            );
          },
        ),
        GoRoute(
          name: 'responsiveRouteName',
          path: '/responsive_page',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(
                page: const ResponsiveTestPage(), pageTitle: 'responsive page'),
          ),
        ),
        // forwarding routes to remove the need to put the 'tab' param in the code
        // GoRoute(
        //   path: '/shop',
        //   redirect: (state) =>
        //       state.namedLocation(homeRouteName, params: {'tab': 'shop'}),
        // ),
        // GoRoute(
        //   path: '/cart',
        //   redirect: (state) =>
        //       state.namedLocation(homeRouteName, params: {'tab': 'cart'}),
        // ),
        // GoRoute(
        //   path: '/profile',
        //   redirect: (state) =>
        //       state.namedLocation(homeRouteName, params: {'tab': 'profile'}),
        // ),
        // GoRoute(
        //   name: detailsRouteName,
        //   path: '/details-redirector/:item',
        //   redirect: (state) => state.namedLocation(
        //     subDetailsRouteName,
        //     params: {'tab': 'shop', 'item': state.params['item']!},
        //   ),
        // ),
        // GoRoute(
        //   name: personalRouteName,
        //   path: '/profile-personal',
        //   redirect: (state) => state.namedLocation(
        //     profilePersonalRouteName,
        //     params: {'tab': 'profile'},
        //   ),
        // ),
        // GoRoute(
        //   name: paymentRouteName,
        //   path: '/profile-payment',
        //   redirect: (state) => state.namedLocation(
        //     profilePaymentRouteName,
        //     params: {'tab': 'profile'},
        //   ),
        // ),
        // GoRoute(
        //   name: signinInfoRouteName,
        //   path: '/profile-signin-info',
        //   redirect: (state) => state.namedLocation(
        //     profileSigninInfoRouteName,
        //     params: {'tab': 'profile'},
        //   ),
        // ),
        // GoRoute(
        //   name: moreInfoRouteName,
        //   path: '/profile-more-info',
        //   redirect: (state) => state.namedLocation(
        //     profileMoreInfoRouteName,
        //     params: {'tab': 'profile'},
        //   ),
        // ),
      ];
  errorPageBuilder(context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: ErrorPage(error: state.error),
      );
}
