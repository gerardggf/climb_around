import 'package:climb_around/app/core/constants/colors.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:climb_around/app/presentation/shared/controllers/session_controller.dart';
import 'package:climb_around/app/presentation/shared/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionsDrawer extends ConsumerWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        context.isDarkMode ? Colors.white : AppColors.light,
                    child: Icon(
                      Icons.person,
                      color: context.isDarkMode ? Colors.black : Colors.white,
                      size: 40,
                    ),
                  ),
                  20.w,
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        ref.watch(sessionControllerProvider)?.name ?? '-',
                        style: context.themeHM,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                context.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              title: Text(
                context.isDarkMode ? 'Dark mode' : 'Light mode',
              ),
              onTap: () {
                ref.read(themeControllerProvider.notifier).updateTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                ref.read(sessionControllerProvider.notifier).logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
