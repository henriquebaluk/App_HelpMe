import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:provider/provider.dart';

import '../core/app_theme.dart' show categoryHue;
import '../models/request_model.dart';
import '../providers/requests_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _map = MapController();

  Color _colorFromHue(double hue) =>
      HSLColor.fromAHSL(1.0, hue, 0.70, 0.50).toColor();

  @override
  Widget build(BuildContext context) {
    final List<RequestModel> items = context.watch<RequestsProvider>().items;

    final coords = <ll.LatLng>[for (final e in items) ll.LatLng(e.lat, e.lng)];

    final markers = items.map<Marker>((e) {
      final color = _colorFromHue(categoryHue(e.category));
      return Marker(
        width: 44,
        height: 44,
        point: ll.LatLng(e.lat, e.lng),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/details', arguments: e),
          child: Icon(Icons.location_on, size: 38, color: color),
        ),
      );
    }).toList();

    final center = coords.isEmpty
        ? const ll.LatLng(-23.5558, -46.6396)
        : coords.first;

    return FlutterMap(
      mapController: _map,
      options: MapOptions(
        initialCenter: center,
        initialZoom: 12,
        interactionOptions: InteractionOptions(
          flags: kIsWeb
              ? InteractiveFlag.drag |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.flingAnimation
              : InteractiveFlag.all,
        ),
        onMapReady: () {
          if (coords.length >= 2) {
            _map.fitCamera(
              CameraFit.coordinates(
                coordinates: coords,
                padding: const EdgeInsets.all(24),
              ),
            );
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.helpme_app',
        ),

        MarkerLayer(markers: markers),

        const RichAttributionWidget(
          attributions: [TextSourceAttribution('© OpenStreetMap contributors')],
        ),
      ],
    );
  }
}
