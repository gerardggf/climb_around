import 'package:climb_around/app/core/constants/global.dart';
import 'package:climb_around/app/presentation/shared/widgets/climb_around_app_bar.dart';
import 'package:climb_around/app/presentation/shared/widgets/error_info_widget.dart';
import 'package:climb_around/app/presentation/shared/widgets/loading_widget.dart';
import 'package:climb_around/app/presentation/shared/widgets/options_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/climbing_spots_repository.dart';
import '../spot_detail/spot_detail_view.dart';
import 'widgets/climbing_spot_card_widget.dart';

/// Fetches the climbing spots from the local JSON file
final fetchClimbingSpotsProvider = FutureProvider(
  (ref) async => ref.watch(climbingSpotsRepoProvider).fetchClimbingSpots(),
);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchClimbingSpotsFuture = ref.watch(fetchClimbingSpotsProvider);
    return Scaffold(
      drawer: const OptionsDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: fetchClimbingSpotsFuture.when(
                    data: (spotsEither) {
                      return spotsEither.when(
                        left: (failure) => ErrorInfoWidget(
                          text: failure.message,
                        ),
                        right: (spots) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(10).copyWith(
                                top: Global.climbAroundAppbarHeight + 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 4 / 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (_, index) => ClimbingSpotCardWidget(
                              spot: spots[index],
                              index: index,
                              onTap: (index) {
                                context.pushNamed(
                                  SpotDetailView.routeName,
                                  extra: spots[index],
                                );
                              },
                            ),
                            itemCount: spots.length,
                          );
                        },
                      );
                    },
                    error: (e, __) => ErrorInfoWidget(
                      text: e.toString(),
                    ),
                    loading: () => const LoadingWidget(),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClimbAroundAppBar(),
            ),
          ],
        ),
      ),
    );
  }
}
