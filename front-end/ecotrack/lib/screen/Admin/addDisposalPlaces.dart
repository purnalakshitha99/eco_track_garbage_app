import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/Admin/adminHomePage.dart'; // Import AdminHomePage
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Place {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class AddDisposalPlaces extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;
  const AddDisposalPlaces({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<AddDisposalPlaces> createState() => _AddDisposalPlacesState();
}

class _AddDisposalPlacesState extends State<AddDisposalPlaces> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = '$localhost/route';
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  int? selectedRouteId; // Change type to int
  String? selectedRouteName;
  List<Map<String, dynamic>> routeNames = [];

  @override
  void initState() {
    super.initState();
    fetchRouteNames();
  }

  Future<void> fetchRouteNames() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'VERSION': 'V1',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          routeNames = responseData.map((route) => {
            'id': route['id'],
            'name': route['name'].toString(),
          }).toList();
        });
      } else {
        print('Failed to fetch route names with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Redirect to AdminHomePage when back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomePage(token: widget.token, userDetails: widget.userDetails),
          ),
        );
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Disposal Places"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<int>( // Change type to int
                          value: selectedRouteId,
                          items: routeNames.map((route) {
                            return DropdownMenuItem<int>( // Change type to int
                              value: route['id'], // Change to int
                              child: Text(route['name'].toString()), // Ensure name is String
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedRouteId = value;
                              selectedRouteName = routeNames.firstWhere((route) => route['id'] == selectedRouteId)['name'].toString(); // Ensure name is String
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Route",
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            prefixIcon: const Icon(Icons.route),
                          ),
                          validator: (value) {
                            if (value == null) { // Check for null
                              return 'Please select a route';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: latitudeController,
                          decoration: InputDecoration(
                            labelText: "Latitude",
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter latitude';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: longitudeController,
                          decoration: InputDecoration(
                            labelText: "Longitude",
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter longitude';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                            child: const Text("Add"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Display selected route information
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Selected Route ID: $selectedRouteId\nSelected Route Name: $selectedRouteName',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    // Check if a route is selected
    if (selectedRouteId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a route'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create a Place object with form data
    Place newPlace = Place(
      id: selectedRouteId!,
      name: selectedRouteName!,
      latitude: double.parse(latitudeController.text),
      longitude: double.parse(longitudeController.text),
    );

    // Convert Place object to JSON
    Map<String, dynamic> payload = newPlace.toJson();

    try {
      // Send data to backend API
      final response = await http.post(
        Uri.parse('$localhost/routes/$selectedRouteId/disposalPlaces'),
        body: jsonEncode(payload),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${widget.token}',
          'VERSION': 'V1',
        },
      );

      // Check response status
      if (response.statusCode == 200) {
        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Disposal Place added successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to admin home page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminHomePage(token: widget.token, userDetails: widget.userDetails),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add disposal place. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }
}
