import 'dart:convert';

import 'package:climb_around/app/core/constants/assets.dart';
import 'package:climb_around/app/core/utils/either/either.dart';
import 'package:climb_around/app/core/utils/failure/failure.dart';
import 'package:climb_around/app/domain/models/climbing_spot_model.dart';
import 'package:climb_around/app/core/utils/typedefs.dart';
import 'package:flutter/services.dart';

import '../../domain/repositories/climbing_spots_repository.dart';

class ClimbingSpotsRepositoryImpl implements ClimbingSpotsRepository {
  @override
  AsyncResult<List<ClimbingSpotModel>> fetchClimbingSpots() async {
    try {
      //load the json file
      final String jsonString =
          await rootBundle.loadString(Assets.climbingSpots);

      // Decode the json
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // convet each element to a ClimbingSpotModel
      List<ClimbingSpotModel> spots = (jsonData['climbing_spots'] as List)
          .map((spot) => ClimbingSpotModel.fromJson(spot))
          .toList();

      return Either.right(spots);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }
}
