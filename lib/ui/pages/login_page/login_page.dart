import 'package:flutter/material.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:md_composer_flutter/ui/loading_layer/loading_layer.dart';
import 'package:md_composer_flutter/utils/snackbar.dart';
import 'package:md_composer_flutter/utils/labels.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(authViewModelProvider);
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
                      Labels.signIn,
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
                      validator: (v) => model.emailValidate(v!),
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
                    const SizedBox(height: 24),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(provider);
                        return MaterialButton(
                          color: scheme.primaryContainer,
                          padding: const EdgeInsets.all(16),
                          onPressed: model.email.isNotEmpty &&
                                  model.password.isNotEmpty
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await model.login();
                                      context.go('/root');
                                    } catch (e) {
                                      AppSnackbar(context).error(e);
                                    }
                                  }
                                }
                              : null,
                          child: Text(Labels.signIn.toUpperCase()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Dont`t have an account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () => context.go('/register'),
                            child: Text(
                              Labels.signUp,
                              style: styles.button!.copyWith(
                                  fontSize: styles.bodyLarge!.fontSize),
                            ))
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    ));
  }
}
