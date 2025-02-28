import 'package:climb_around/app/core/constants/colors.dart';
import 'package:climb_around/app/core/constants/global.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:climb_around/app/presentation/modules/sign-in/state/signin_state.dart';
import 'package:climb_around/app/presentation/shared/utils/dialogs.dart';
import 'package:climb_around/app/presentation/shared/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_around/app/presentation/modules/sign-in/sign_in_controller.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  static const String routeName = '/sign-in';

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
    final state = ref.watch(signInControllerProvider);
    final notifier = ref.read(signInControllerProvider.notifier);
    ref.listen(
      signInControllerProvider,
      (prev, next) {
        if (prev == next) return;
        if (!context.mounted) return;
        next.maybeWhen(
          error: (err) {
            ClimbAroundDialogs.snackBar(
              context: context,
              text: err,
              color: AppColors.error,
            );
          },
          orElse: () {
            ClimbAroundDialogs.snackBar(
              context: context,
              text: 'Logged in successfully',
            );
          },
        );
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          if (state == const SignInState.loading())
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white54),
                child: Center(
                  child: CircularProgressIndicator(
                    color:
                        context.isDarkMode ? AppColors.dark : AppColors.light,
                  ),
                ),
              ),
            ),
          AbsorbPointer(
            absorbing: state == const SignInState.loading(),
            child: Form(
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
                        style: context.themeLS
                            ?.copyWith(fontStyle: FontStyle.italic),
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
                        validator: (value) =>
                            FormValidators.validateEmail(value),
                        decoration: const InputDecoration(
                          hintText: 'test@test.com',
                          label: Text('Email'),
                        ),
                      ),
                      20.h,
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) =>
                            FormValidators.validatePassword(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: '1234',
                          label: Text('Password'),
                        ),
                      ),
                      20.h,
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
                          await notifier.signIn(
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
          ),
        ],
      ),
    );
  }
}
