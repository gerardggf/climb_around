import 'package:climb_around/app/data/repositories_impl/climbing_spots_repository_impl.dart';
import 'package:climb_around/app/domain/models/climbing_spot_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_around/app/core/utils/typedefs.dart';

final climbingSpotsRepoProvider = Provider<ClimbingSpotsRepository>(
  (ref) => ClimbingSpotsRepositoryImpl(),
);

abstract class ClimbingSpotsRepository {
  /// Fetches the climbing spots from the local JSON file
  AsyncResult<List<ClimbingSpotModel>> fetchClimbingSpots();
}
