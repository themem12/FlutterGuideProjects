import 'dart:async';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapScreen extends StatelessWidget {
   const FullMapScreen({super.key});

   @override
   Widget build(BuildContext context) {
      return const Scaffold(
         body: Center(
            child: MapView(),
         ),
      );
   }
}

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.427538856463627, -99.16524833034974),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    var googleMap = GoogleMap(
        myLocationButtonEnabled: false,
        mapType: _mapType,
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        onTap: _createMarker,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
    return Scaffold(
      body: googleMap,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _createMarkerButtonTapped,
            child: const Icon(Icons.maps_home_work_outlined),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: _changeLayer,
            child: const Icon(Icons.layers_outlined),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: _zoomOutOnMap,
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: _zoomInOnMap,
            child: const Icon(Icons.zoom_in),
          ),
        ]
      ),
    );
  }

  _changeLayer() {
    if(_mapType == MapType.normal) {
      _mapType = MapType.satellite;
    } else {
      _mapType = MapType.normal;
    }

    setState(() {});
  }

  Future<void> _zoomInOnMap() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOutOnMap() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  _createMarkerButtonTapped() async {
    final GoogleMapController controller = await _controller.future;
    final visibleRegion = await controller.getVisibleRegion();

    _createMarker(_getCenterPoint(visibleRegion.northeast, visibleRegion.southwest));
  }

  _createMarker(LatLng tappedPoint) {
    final markerId = MarkerId(const Uuid().v1());
    _markers.add(
      Marker(
        markerId: markerId,
        position: tappedPoint,//visibleRegion.northeast 
        
        infoWindow: InfoWindow(
          title: 'Marker',
          snippet: 'Lat: ${tappedPoint.latitude}\nLng: ${tappedPoint.longitude}'
        )
      )
    );
    setState(() {});
  }

  LatLng _getCenterPoint(LatLng northeast, LatLng southwest) {
    return LatLng(
      (northeast.latitude + southwest.latitude) / 2,
      (northeast.longitude + southwest.longitude) / 2
    );
  }
}