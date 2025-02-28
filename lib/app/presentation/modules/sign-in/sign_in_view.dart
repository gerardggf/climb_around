import 'package:climb_around/app/core/constants/global.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:climb_around/app/presentation/shared/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_around/app/presentation/modules/sign-in/sign_in_controller.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  static const String routeName = 'sign-in';

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signInControllerProvider.notifier);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.hiking, size: 50),
                Text(
                  Global.appName,
                  style: context.themeHL,
                ),
                Text(
                  'Keep it minimalist',
                  style: context.themeLS?.copyWith(fontStyle: FontStyle.italic),
                ),
                20.h,
                Text(
                  'Sign in',
                  style: context.themeBL,
                ),
                10.h,
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => FormValidators.validateEmail(value),
                  decoration: const InputDecoration(
                    hintText: 'test@test.com',
                    label: Text('Email'),
                  ),
                ),
                20.h,
                TextFormField(
                  controller: _passwordController,
                  validator: (value) => FormValidators.validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: '1234',
                    label: Text('Password'),
                  ),
                ),
                20.h,
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    notifier.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
