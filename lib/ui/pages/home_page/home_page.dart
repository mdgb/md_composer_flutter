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

    return Row(
      children: [
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: const Text('HOME PAGE')),
          ),
        ),
      ],
    );
  }
}
