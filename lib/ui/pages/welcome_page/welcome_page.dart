import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const Text("WELCOME",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 54, 9, 218),
                      fontWeight: FontWeight.bold)),
              const Text(
                "Your account has been  successfuly created. THANK YOU",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 6, 211, 16)),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(authViewModelProvider).logout();
                  context.go('/');
                },
                child: const Text("Logout"),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.go('/root');
                },
                child: const Text("Home"),
              ),
            ]),
          ),
        ));
  }
}
