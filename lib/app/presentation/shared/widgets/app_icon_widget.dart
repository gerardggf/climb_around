import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    super.key,
    this.radius = 50,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.isDarkMode ? AppColors.dark : AppColors.light,
      child: Icon(
        Icons.hiking,
        size: radius + 10,
        color: Colors.white,
      ),
    );
  }
}
