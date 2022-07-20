import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/ui/pages/animations/animated_carousel_1.dart';
import 'package:md_composer_flutter/ui/pages/animations/animated_drawer_1.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/gallery_detail_page.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/gallery_page.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/post_details_page.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/posts_page.dart';
import 'package:md_composer_flutter/ui/pages/factory_test/factory_test_widget.dart';
import 'package:md_composer_flutter/ui/pages/forms/forms_page.dart';
import 'package:md_composer_flutter/ui/pages/reponsive_test_page/reponsive_test_page.dart';
import 'package:md_composer_flutter/ui/pages/slivers_page/sliver_sticky.dart';
import 'package:md_composer_flutter/ui/pages/typography_page/typography_page.dart';
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
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const SplashPage(),
          ),
          // redirect: (state) => state.namedLocation(homeRouteName),
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
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: BaseTemplate(page: const HomePage(), pageTitle: 'Home'),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
        GoRoute(
          name: 'animatedCarousel',
          path: '/animated_carousel_1',
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: AnimatedCarousel(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
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
        GoRoute(
          name: 'typography',
          path: '/typography',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(
                page: const TypographyPage(), pageTitle: 'Typography'),
          ),
        ),
        GoRoute(
          name: 'forms',
          path: '/forms',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(
                page: FormBuilderExamplePage(), pageTitle: 'Forms Example'),
          ),
        ),
        GoRoute(
          name: 'factory',
          path: '/factory',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(
                page: FactoryTestWidgets(), pageTitle: 'Factory Test'),
          ),
        ),
        GoRoute(
          name: 'sticky_box',
          path: '/sticky_box',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child:
                BaseTemplate(page: StickyBox(), pageTitle: 'StickyBox Sliver'),
          ),
        ),
        GoRoute(
          name: 'posts',
          path: '/posts',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(page: Posts(), pageTitle: 'Posts'),
          ),
        ),
        GoRoute(
          name: 'post_detail',
          path: '/post_detail',
          builder: (context, state) =>
              PostDetailPage(post: state.extra! as Post),
        ),
        GoRoute(
          name: 'gallery',
          path: '/gallery',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BaseTemplate(page: GalleryPage(), pageTitle: 'Gallery'),
          ),
        ),
        GoRoute(
          name: 'gallery_detail',
          path: '/gallery_detail',
          builder: (context, state) =>
              GalleryDetailPage(galleryItem: state.extra! as GalleryItem),
        ),
        GoRoute(
          name: 'animated_drawer_1',
          path: '/animated_drawer_1',
          builder: (context, state) => AnimatedDrawer1(),
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
