import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Lottie.asset('assets/lottie/92753-google-logo.json',
                  repeat: false,
                  height: MediaQuery.of(context).size.height / 2),
              Text("WELCOME",
                  style: TextStyle(
                      fontSize: 40,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold)),
              Text(
                "Your account has been  successfuly created. THANK YOU",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(authViewModelProvider).logout();
                    context.go('/');
                  },
                  child: const Text("Logout"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    context.go('/root');
                  },
                  child: const Text("Home"),
                ),
              ),
            ]),
          ),
        ));
  }
}
