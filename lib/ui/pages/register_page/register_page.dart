import 'dart:developer';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:md_composer_flutter/ui/loading_layer/loading_layer.dart';
import 'package:md_composer_flutter/utils/snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/labels.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  static const String route = "/register";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(provider);
    final height = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return LoadingLayer(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.apple_outlined,
                      size: 80,
                      color: scheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Labels.appName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: styles.titleLarge,
                    ),
                    SizedBox(height: height / 12),
                    Text(
                      Labels.signUp,
                      style: styles.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      initialValue: model.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: Labels.email,
                      ),
                      onChanged: (v) => model.email = v,
                    ),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(
                            provider.select((value) => value.obscurePassword));
                        return TextFormField(
                          obscureText: model.obscurePassword,
                          initialValue: model.password,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            labelText: Labels.password,
                            suffixIcon: IconButton(
                              onPressed: () {
                                model.obscurePassword = !model.obscurePassword;
                              },
                              icon: Icon(model.obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                            ),
                          ),
                          onChanged: (v) => model.password = v,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(provider
                            .select((value) => value.obscureConfirmPassword));
                        return TextFormField(
                          obscureText: model.obscureConfirmPassword,
                          initialValue: model.confirmPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            labelText: Labels.confirmPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                model.obscureConfirmPassword =
                                    !model.obscureConfirmPassword;
                              },
                              icon: Icon(model.obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                            ),
                          ),
                          onChanged: (v) => model.confirmPassword = v,
                          validator: (v) =>
                              v != model.password ? "Mismatch Password!" : null,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(provider);
                        return MaterialButton(
                          color: scheme.primaryContainer,
                          padding: const EdgeInsets.all(16),
                          onPressed: () async {
                            if (model.email.isNotEmpty &&
                                model.password.isNotEmpty &&
                                model.confirmPassword.isNotEmpty) {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await model.register();
                                  context.go('/welcome');
                                } catch (e) {
                                  AppSnackbar(context).error(e);
                                }
                              }
                            } else {}
                          },
                          child: Text(Labels.signUp.toUpperCase()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () => context.go('/login'),
                            child: Text(
                              Labels.signIn,
                              style: styles.button!.copyWith(
                                  fontSize: styles.bodyLarge!.fontSize),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
