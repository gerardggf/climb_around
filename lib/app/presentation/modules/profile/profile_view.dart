import 'package:climb_around/app/core/constants/assets.dart';
import 'package:climb_around/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:climb_around/app/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WIP',
                style: context.themeHL,
              ),
              20.h,
              SvgPicture.asset(
                Assets.wipProfileSvg,
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
              30.h,
              const Text('Nothing to see here... At least for now...'),
            ],
          ),
        ),
      ),
    );
  }
}
