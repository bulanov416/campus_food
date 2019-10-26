import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapView extends StatefulWidget {
  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Text('MapView');
  }

}




//
//
//Widget mapView(BuildContext context) {
//  Completer<GoogleMapController> _controller = Completer();
//  const LatLng _center = const LatLng(45.521563, -122.677433);
//  final Set<Marker> _markers = {};
//  LatLng _lastMapPosition = _center;
//  MapType _currentMapType = MapType.normal;
//
//  _onMapCreated(GoogleMapController controller) {
//    _controller.complete(controller);
//  }
//
//  _onCameraMove(CameraPosition position) {
//    _lastMapPosition = position.target;
//  }
//
//  Widget button(Function function, IconData icon) {
//    return FloatingActionButton(
//      onPressed: function,
//      materialTapTargetSize: MaterialTapTargetSize.padded,
//      backgroundColor: Colors.blue,
//      child: Icon(icon, size: 36),
//    );
//  }
//
//  _onMapTypeButtonPressed() {
//      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite: MapType.normal;
//  }
//
//  _onAddMarkerButtonPressed() {
//    _markers.add(Marker(
//      markerId: MarkerId(_lastMapPosition.toString()),
//      position: _lastMapPosition,
//      infoWindow: InfoWindow(
//        title: 'This is a title',
//        snippet: 'This is a snippet'
//      ),
//      icon: BitmapDescriptor.defaultMarker,
//    ));
//  }
//
//  return Scaffold(
//    body: Stack(
//      children: <Widget>[
//        GoogleMap(
//          onMapCreated: _onMapCreated,
//          initialCameraPosition: CameraPosition(
//            target: _center,
//            zoom: 11.0,
//          ),
//          mapType: _currentMapType,
//          markers: _markers,
//          onCameraMove: _onCameraMove,
//        ),
//        Padding(
//          padding: EdgeInsets.all(16),
//          child: Align(
//            alignment: Alignment.topRight,
//            child: Column(
//              children: <Widget>[
//                button(_onMapTypeButtonPressed, Icons.map),
//                SizedBox(height: 16.0),
//                button(_onAddMarkerButtonPressed, Icons.add_location),
//              ],
//            ),
//          ),
//        )
//      ],
//    )
//  );
//}
