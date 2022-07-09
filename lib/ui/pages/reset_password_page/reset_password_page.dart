import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../services/auth_services.dart';
import '../../../utils/labels.dart';
import '../../../utils/snackbar.dart';
import '../../loading_layer/loading_layer.dart';

class ResetPasswordPage extends ConsumerWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(authViewModelProvider);

    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                  const SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, child) {
                      ref.watch(provider);
                      return MaterialButton(
                        color: scheme.primaryContainer,
                        padding: const EdgeInsets.all(16),
                        onPressed:
                            model.email.isNotEmpty && model.password.isNotEmpty
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        await model.changePasswords();
                                        context.go('/root');
                                      } catch (e) {
                                        AppSnackbar(context).error(e);
                                      }
                                    }
                                  }
                                : null,
                        child: Text(Labels.resetPassword.toUpperCase()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
