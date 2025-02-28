import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/colors.dart';

class ClimbAroundDialogs {
  ClimbAroundDialogs._();

  static void snackBar({
    required BuildContext context,
    required String text,
    Color? color,
    int milliseconds = 2500,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color != null
                  ? Colors.white
                  : context.isDarkMode
                      ? Colors.black
                      : AppColors.light,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }

  /// Custom dialog for multiple purposes
  static Future<bool> custom({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return await showDialog<bool?>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
