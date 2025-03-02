import 'package:climb_around/app/domain/models/climbing_spot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/assets.dart';
import 'map_marker_item_widget.dart';

///We can't use a useState hook in this widget because it doesn't work for MapController
///and we can't init the controller in a useEffect hook because this hook can't manage
///the destruction of the controller (so it has to be done using `dispose()`)
class MapWidget extends ConsumerStatefulWidget {
  const MapWidget({super.key, required this.spot});
  final ClimbingSpotModel spot;

  @override
  ConsumerState<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends ConsumerState<MapWidget> {
  late MapController _mapController;

  bool hideDetailedMarkers = false, smallMarkers = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(
          widget.spot.coordinates.latitude,
          widget.spot.coordinates.longitude,
        ),
        initialZoom: 14,
        onPositionChanged: (position, hasGesture) {
          const double hideNamesZoomValue = 11.5;

          if ((position.zoom) < hideNamesZoomValue && !hideDetailedMarkers) {
            setState(() {
              hideDetailedMarkers = true;
            });
          }
          if ((position.zoom) >= hideNamesZoomValue && hideDetailedMarkers) {
            setState(() {
              hideDetailedMarkers = false;
            });
          }
          const double showSmallMarkers = 6;
          if ((position.zoom) < showSmallMarkers && !smallMarkers) {
            setState(() {
              smallMarkers = true;
            });
          }
          if ((position.zoom) >= showSmallMarkers && smallMarkers) {
            setState(() {
              smallMarkers = false;
            });
          }
        },
      ),
      children: [
        TileLayer(
          errorImage: const AssetImage(Assets.icon),
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.gerardggf.climbaround',
        ),
        MarkerLayer(
          rotate: true,
          markers: [
            Marker(
              point: LatLng(
                widget.spot.coordinates.latitude,
                widget.spot.coordinates.longitude,
              ),
              width: 200,
              height: 110,
              child: const Center(child: MapMarkerItemWidget()),
            ),
          ],
        ),
      ],
    );
  }
}
