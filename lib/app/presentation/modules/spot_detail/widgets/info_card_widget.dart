import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.child,
  });
  final String title, value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          if (child != null)
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: child!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.themeHS,
                  ),
                ),
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
