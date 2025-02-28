import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';

class MapMarkerItemWidget extends ConsumerWidget {
  const MapMarkerItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: context.isDarkMode ? AppColors.dark : AppColors.light,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Assets.icon,
                color: Colors.white,
              ),
            ),
            CustomPaint(
              size: const Size(20, 10),
              painter: _PinIndicatorPainter(
                color: context.isDarkMode ? AppColors.dark : AppColors.light,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PinIndicatorPainter extends CustomPainter {
  final Color color;

  _PinIndicatorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
