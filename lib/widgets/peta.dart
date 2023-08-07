import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toko_app_2/screens/products_overview_screen.dart';

import '../utils/map_style.dart';

const MARKER_COLOR = Color(0xff00E057);

final _myLocation = LatLng(-6.280325061088294, 106.6618943775601);

class Peta extends StatefulWidget {
  static const routeName = '/peta';
  const Peta({Key key}) : super(key: key);

  @override
  State<Peta> createState() => _PetaState();
}

class _PetaState extends State<Peta> {
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-6.215110958435393, 106.79705937315931),
    zoom: 15,
  );

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/img/marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialPosition,
              // Markers Location
              markers: {
                Marker(
                  markerId: const MarkerId("Cilandak Town Square"),
                  position: const LatLng(-6.291415403009179, 106.7989752775441),
                  draggable: true,
                  onDragEnd: (value) {
                    // value is the new position
                  },
                  icon: markerIcon,
                  // To do: custom marker icon
                ),
                Marker(
                  markerId: const MarkerId("Summarecon Mall Serpong"),
                  position:
                      const LatLng(-6.239876307900313, 106.62833591892559),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("M Bloc Space"),
                  position:
                      const LatLng(-6.240962283729389, 106.79876398478858),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Summarecon Mall Bekasi"),
                  position:
                      const LatLng(-6.226053313236176, 107.00107603824479),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("CIPLAZ Depok (Ramayana)"),
                  position:
                      const LatLng(-6.390638088504455, 106.82510591920816),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Novotel Bukittinggi"),
                  position:
                      const LatLng(-0.30576602009570597, 100.36798229676072),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Pantai Batu Bolong"),
                  position:
                      const LatLng(-8.657770712122423, 115.13014513705548),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Hotel Grand Papua Sentani"),
                  position:
                      const LatLng(-2.555893130699946, 140.49563906594935),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Aeon Mall KYOTO"),
                  position:
                      const LatLng(34.983919966846244, 135.75459673723412),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("Anantara The Palm Dubai Resort"),
                  position: const LatLng(25.13090029433938, 55.15302313190382),
                  draggable: true,
                  icon: markerIcon,
                ),
                Marker(
                  markerId: const MarkerId("bonaˊme Köln-Deutz"),
                  position: const LatLng(50.93752795452767, 6.969679656473325),
                  draggable: true,
                  icon: markerIcon,
                ),
              },
              zoomControlsEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(jsonEncode(mapStyle));
              },
            ),
            IconButton(
              icon: const Icon(
                FeatherIcons.chevronLeft,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductsOverviewScreen();
                    },
                  ),
                );
                // locator
                //     .get<LayananNavigasi>()
                //     .navigatorKey
                //     .currentState!
                //     .pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
