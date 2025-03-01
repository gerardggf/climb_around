import 'package:climb_around/app/core/constants/colors.dart';
import 'package:climb_around/app/core/constants/global.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:climb_around/app/presentation/modules/sign-in/state/signin_state.dart';
import 'package:climb_around/app/presentation/shared/controllers/theme_controller.dart';
import 'package:climb_around/app/presentation/shared/utils/dialogs.dart';
import 'package:climb_around/app/presentation/shared/utils/form_validators.dart';
import 'package:climb_around/app/presentation/shared/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:climb_around/app/presentation/modules/sign-in/sign_in_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/painters/wave_painters.dart';

class SignInView extends HookConsumerWidget {
  SignInView({super.key});

  static const String routeName = '/sign-in';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInControllerProvider);
    final notifier = ref.read(signInControllerProvider.notifier);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isChecked = useState<bool>(false);

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
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: CustomPaint(
                size: Size(
                  double.infinity,
                  MediaQuery.sizeOf(context).height * 0.15,
                ),
                painter: UpperWavePainter(
                  color: context.isDarkMode
                      ? AppColors.dark.withAlpha(50)
                      : AppColors.light.withAlpha(50),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(
                  double.infinity,
                  MediaQuery.sizeOf(context).height * 0.4,
                ),
                painter: LowerWavePainter(
                  color: context.isDarkMode
                      ? AppColors.dark.withAlpha(50)
                      : AppColors.light.withAlpha(50),
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
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: AppIconWidget(),
                      ),
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
                        controller: emailController,
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
                        controller: passwordController,
                        validator: (value) =>
                            FormValidators.validatePassword(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: '1234',
                          label: Text('Password'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'I\'m logging in with fake credentials',
                            ),
                            5.w,
                            Switch(
                              value: isChecked.value,
                              onChanged: (value) {
                                isChecked.value = !isChecked.value;
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
                          await notifier.signIn(
                            emailController.text,
                            passwordController.text,
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
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  ref.read(themeControllerProvider.notifier).updateTheme();
                },
                icon: Icon(
                  context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
