import 'package:climb_around/app/presentation/shared/widgets/climb_around_app_bar.dart';
import 'package:climb_around/app/presentation/shared/widgets/options_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const OptionsDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const ClimbAroundAppBar(),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
