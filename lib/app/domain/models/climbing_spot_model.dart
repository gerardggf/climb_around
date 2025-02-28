class ClimbingSpotModel {
  final int id;
  final String name;
  final String country;
  final String region;
  final CoordinatesModel coordinates;
  final String rockType;
  final String difficultyRange;
  final List<RouteModel> highlightRoutes;
  final AccessInfoModel accessInfo;
  final ServicesNearbyModel servicesNearby;
  final String imageUrl;

  ClimbingSpotModel({
    required this.id,
    required this.name,
    required this.country,
    required this.region,
    required this.coordinates,
    required this.rockType,
    required this.difficultyRange,
    required this.highlightRoutes,
    required this.accessInfo,
    required this.servicesNearby,
    required this.imageUrl,
  });

  factory ClimbingSpotModel.fromJson(Map<String, dynamic> json) {
    return ClimbingSpotModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      region: json['region'],
      coordinates: CoordinatesModel.fromJson(json['coordinates']),
      rockType: json['rock_type'],
      difficultyRange: json['difficulty_range'],
      highlightRoutes: (json['highlight_routes'] as List)
          .map((route) => RouteModel.fromJson(route))
          .toList(),
      accessInfo: AccessInfoModel.fromJson(json['access_info']),
      servicesNearby: ServicesNearbyModel.fromJson(json['services_nearby']),
      imageUrl: json['image_url'] ?? 'https://picsum.photos/200/300',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "region": region,
        "coordinates": coordinates.toJson(),
        "rock_type": rockType,
        "difficulty_range": difficultyRange,
        "highlight_routes":
            highlightRoutes.map((route) => route.toJson()).toList(),
        "access_info": accessInfo.toJson(),
        "services_nearby": servicesNearby.toJson(),
        "image_url": imageUrl,
      };
}

class CoordinatesModel {
  final double latitude;
  final double longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"latitude": latitude, "longitude": longitude};
}

class RouteModel {
  final String name;
  final String grade;
  final int lengthMeters;

  RouteModel(
      {required this.name, required this.grade, required this.lengthMeters});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      name: json['name'],
      grade: json['grade'],
      lengthMeters: json['length_meters'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"name": name, "grade": grade, "length_meters": lengthMeters};
}

class AccessInfoModel {
  final bool parkingAvailable;
  final int hikeTimeMinutes;
  final String recommendedSeason;

  AccessInfoModel({
    required this.parkingAvailable,
    required this.hikeTimeMinutes,
    required this.recommendedSeason,
  });

  factory AccessInfoModel.fromJson(Map<String, dynamic> json) {
    return AccessInfoModel(
      parkingAvailable: json['parking_available'],
      hikeTimeMinutes: json['hike_time_minutes'],
      recommendedSeason: json['recommended_season'],
    );
  }

  Map<String, dynamic> toJson() => {
        "parking_available": parkingAvailable,
        "hike_time_minutes": hikeTimeMinutes,
        "recommended_season": recommendedSeason
      };
}

class ServicesNearbyModel {
  final bool camping;
  final bool restaurants;
  final bool gearShop;

  ServicesNearbyModel({
    required this.camping,
    required this.restaurants,
    required this.gearShop,
  });

  factory ServicesNearbyModel.fromJson(Map<String, dynamic> json) {
    return ServicesNearbyModel(
      camping: json['camping'],
      restaurants: json['restaurants'],
      gearShop: json['gear_shop'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"camping": camping, "restaurants": restaurants, "gear_shop": gearShop};
}
