import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Route1 extends StatefulWidget {
  @override
  _Route1State createState() => _Route1State();
}

class _Route1State extends State<Route1> {
  late GoogleMapController mapController;
  List<UserLocation>? userLocations = [];

  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _loadUserLocations();
    _getUserLocation();
  }

  Future<void> _loadUserLocations() async {
    try {
      String data =
          await rootBundle.loadString('asset/user_locations.json');

      List<dynamic> jsonList = json.decode(data);

      setState(() {
        userLocations = jsonList
            .map<UserLocation>((item) => UserLocation(
                  name: item['name'],
                  latitude: item['latitude'],
                  longitude: item['longitude'],
                ))
            .toList();
      });
    } catch (e) {
      print('Error loading user locations: $e');
    }
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        userLocations!.add(UserLocation(
            name: 'My Location',
            latitude: position.latitude,
            longitude: position.longitude));
      });
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colombo Areas'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(6.9350, 79.9827),
          zoom: 15,
        ),
        circles: Set.from([
          Circle(
            circleId: CircleId('Area1'),
            center: LatLng(6.9350, 79.9827),
            radius: 1000,
            fillColor: Colors.red.withOpacity(0.5),
            strokeWidth: 2,
            strokeColor: Colors.red,
          ),
        ]),
        markers: _buildMarkers(),
        polylines: polylines,
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    if (userLocations != null) {
      markers.addAll(userLocations!.map((location) => Marker(
            markerId: MarkerId(location.name),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: location.name,
              snippet: 'User Location',
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            onTap: () {
              _calculateAndDrawRoute(
                  LatLng(userLocations!.last.latitude,
                      userLocations!.last.longitude),
                  LatLng(location.latitude, location.longitude));
            },
          )));
    }

    if (userLocations!.isNotEmpty) {
      markers.add(Marker(
        markerId: MarkerId('My Location'),
        position:
            LatLng(userLocations!.last.latitude, userLocations!.last.longitude),
        infoWindow:
            InfoWindow(title: 'My Location', snippet: 'Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
    }

    return markers;
  }

  Future<void> _calculateAndDrawRoute(LatLng origin, LatLng destination) async {
    String apiKey = '5b3ce3597851110001cf6248c89b2b368ff646358f22d8eac19be3a3';

    String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${origin.longitude},${origin.latitude}&end=${destination.longitude},${destination.latitude}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      List<dynamic> features = data['features'];
      if (features.isNotEmpty) {
        List<dynamic> geometry = features[0]['geometry']['coordinates'];
        List<LatLng> points =
            geometry.map((point) => LatLng(point[1], point[0])).toList();

        setState(() {
          polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: points,
            color: Colors.blue,
            width: 5,
          ));
        });
      } else {
        print('No route found.');
      }
    } else {
      print('Failed to load directions: ${response.statusCode}');
    }
  }
}

class UserLocation {
  final String name;
  final double latitude;
  final double longitude;

  UserLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

void main() {
  runApp(MaterialApp(
    home: Route1(),
  ));
}
