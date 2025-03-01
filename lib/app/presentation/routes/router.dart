import 'package:climb_around/app/domain/models/climbing_spot_model.dart';
import 'package:climb_around/app/domain/repositories/prefs_repository.dart';
import 'package:climb_around/app/presentation/modules/spot_detail/spot_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:climb_around/app/core/constants/assets.dart';
import 'package:climb_around/app/domain/models/user_model.dart';
import 'package:climb_around/app/presentation/modules/profile/profile_view.dart';
import 'package:climb_around/app/presentation/modules/sign-in/sign_in_view.dart';
import 'package:climb_around/app/presentation/shared/controllers/session_controller.dart';

import '../../core/generated/translations.g.dart';
import '../shared/widgets/error_info_widget.dart';
import '../modules/home/home_view.dart';
import '../modules/splash/splash_view.dart';

final userLoaderFutureProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.read(prefsRepoProvider).userLogged;
  if (user != null) {
    Future.microtask(
      () => ref.read(sessionControllerProvider.notifier).setUser(user),
    );
  }
  return user;
});

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final userLoaderState = ref.watch(userLoaderFutureProvider);
    final userAuthState = ref.watch(sessionControllerProvider);
    return GoRouter(
      errorBuilder: (context, state) => Scaffold(
        body: ErrorInfoWidget(
          text: texts.global.pageNotFound,
          icon: Image.asset(
            Assets.icon,
            width: 50,
            height: 50,
          ),
        ),
      ),
      initialLocation: '/',
      redirect: (context, state) {
        if (userLoaderState.isLoading) {
          if (state.uri.toString() != '/') return '/';
          return null;
        }

        if (userAuthState == null) {
          if (state.uri.toString() != '/sign-in') return '/sign-in';
          return null;
        }

        if (state.uri.toString() == '/sign-in' || state.uri.toString() == '/') {
          return '/home';
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SplashView.routeName,
          path: '/',
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          name: HomeView.routeName,
          path: '/home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          name: SignInView.routeName,
          path: '/sign-in',
          builder: (context, state) => SignInView(),
        ),
        GoRoute(
          name: ProfileView.routeName,
          path: '/profile',
          builder: (context, state) => const ProfileView(),
        ),

        //If we wanted to make it suitable for Navigation 2.0 we should use the spot id as
        //pathParameter (/:id) and retrieve the element with that id from the climbing spots
        //already fetched
        GoRoute(
          name: SpotDetailView.routeName,
          path: '/spot-detail',
          builder: (context, state) => SpotDetailView(
            spot: state.extra as ClimbingSpotModel,
          ),
        ),
      ],
    );
  },
);
