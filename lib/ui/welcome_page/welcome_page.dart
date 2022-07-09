import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/services/auth_services.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Text("WELCOME",
                style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 54, 9, 218),
                    fontWeight: FontWeight.bold)),
            Text(
              "Your account has been  successfuly created. THANK YOU",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 6, 211, 16)),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authViewModelProvider).logout();
              },
              child: const Text("Logout"),
            ),
          ]),
        ));
  }
}
