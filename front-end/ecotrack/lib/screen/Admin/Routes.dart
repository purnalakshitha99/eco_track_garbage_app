import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/Admin/addRout.dart';
import 'package:ecotrack/screen/Admin/adminHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RouteResponseDTO {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  RouteResponseDTO({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory RouteResponseDTO.fromJson(Map<String, dynamic> json) {
    return RouteResponseDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

class Routes extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const Routes({Key? key, required this.token, required this.userDetails})
      : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  List<RouteResponseDTO> routesData = [];

  @override
  void initState() {
    super.initState();
    fetchRoutesData();
  }

  Future<void> fetchRoutesData() async {
    final apiUrl = '$localhost/route';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
          'VERSION': 'V1',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          routesData = responseData
              .map((route) => RouteResponseDTO.fromJson(route))
              .toList();
        });
      } else {
        print('Failed to fetch routes data with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteRoute(int routeId) async {
    final apiUrl = '$localhost/routes/$routeId';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
          'VERSION': 'V1',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          routesData.removeWhere((route) => route.id == routeId);
        });
        print('Route deleted successfully');
      } else {
        print('Failed to delete route with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Routes"),
      leading: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage(token: widget.token, userDetails: widget.userDetails)));
      }, icon: Icon(Icons.arrow_back))
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Table(
            border: TableBorder.all(color: const Color.fromARGB(77, 7, 7, 7)),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Name"),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Latitude"),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Longitude"),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Actions"),
                    ),
                  ),
                ],
              ),
              ...routesData.map((route) {
                return TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(route.name),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(route.latitude.toString()),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(route.longitude.toString()),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,color: Colors.green,size: 30,),
                          onPressed: () {
                            // Implement edit functionality
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,size: 30,),
                            onPressed: () {
                              deleteRoute(route.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
               );
              }
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRoute(token: widget.token, userDetails: widget.userDetails
        )
      )
    );
  },
  child: const Icon(Icons.arrow_forward_rounded),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
