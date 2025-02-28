import 'dart:ui';

import 'package:climb_around/app/core/constants/colors.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:climb_around/app/presentation/shared/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/global.dart';

class ClimbAroundAppBar extends ConsumerWidget {
  const ClimbAroundAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          stops: const [0.4, 1],
          colors: context.isDarkMode
              ? [AppColors.darkBg, AppColors.darkBg.withAlpha(0)]
              : [Colors.white, Colors.white.withAlpha(0)],
        ),
      ),
      width: double.infinity,
      height: Global.climbAroundAppbarHeight,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Row(
            children: [
              1.w,
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              10.w,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 28,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Hi ',
                            ),
                            TextSpan(
                              text:
                                  ref.watch(sessionControllerProvider)?.name ??
                                      '- ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text('Welcome to your trusted climbing app'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
