import 'package:climb_around/app/presentation/shared/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
    this.error,
  });

  final String? error;

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.3,
              ),
              child: Column(
                children: [
                  const AppIconWidget(
                    radius: 80,
                  ),
                  30.h,
                  if (error != null)
                    Text(
                      error!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
