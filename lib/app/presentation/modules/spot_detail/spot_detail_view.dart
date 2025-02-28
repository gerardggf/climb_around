import 'package:climb_around/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:climb_around/app/presentation/modules/spot_detail/widgets/info_card_widget.dart';
import 'package:climb_around/app/presentation/modules/spot_detail/widgets/list_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../domain/models/climbing_spot_model.dart';

class SpotDetailView extends StatelessWidget {
  const SpotDetailView({
    super.key,
    required this.spot,
  });

  final ClimbingSpotModel spot;

  static const routeName = '/spot-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(spot.name),
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    spot.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                          stops: const [0.1, 0.7, 1],
                          colors: context.isDarkMode
                              ? [
                                  AppColors.darkBg,
                                  AppColors.darkBg.withAlpha(150),
                                  AppColors.darkBg.withAlpha(0)
                                ]
                              : [
                                  Colors.white,
                                  Colors.white.withAlpha(150),
                                  Colors.white.withAlpha(0),
                                ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20).copyWith(
                        top: MediaQuery.paddingOf(context).top +
                            kToolbarHeight, // add status bar padding because we are not using safeare for this screen
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  InfoCardWidget(
                      title: "🌍 Location",
                      value: "${spot.region}, ${spot.country}"),
                  InfoCardWidget(title: "🪨 Rock type", value: spot.rockType),
                  InfoCardWidget(
                      title: "⚡ Difficulty", value: spot.difficultyRange),
                  ListCardWidget(
                      title: '🔝 Featured routes',
                      values: spot.highlightRoutes
                          .map((e) =>
                              '${e.name}-${e.grade} (${e.lengthMeters}m)')
                          .toList()),
                  InfoCardWidget(
                    title: "🚶‍♂️ Access",
                    value:
                        "${spot.accessInfo.hikeTimeMinutes} min - ${spot.accessInfo.recommendedSeason}",
                  ),
                  ListCardWidget(
                    title: '🏕️ Nearby services',
                    values: [
                      '${spot.servicesNearby.camping ? '✅' : '❌'} Camping',
                      '${spot.servicesNearby.restaurants ? '✅' : '❌'} Restaurants',
                      '${spot.servicesNearby.gearShop ? '✅' : '❌'} Gear shops',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
