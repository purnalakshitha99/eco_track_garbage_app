import 'package:ecotrack/screen/TruckDriver/CheckRequest.dart';
import 'package:ecotrack/screen/TruckDriver/complain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TruckDriverHomePage extends StatelessWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;
  const TruckDriverHomePage({Key? key, required this.token, required this.userDetails}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello Driver",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white, // Set app bar background color
        elevation: 0, // Remove app bar shadow
      ),
      backgroundColor: Colors.white, // Set background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, // Adjust shadow color
                    spreadRadius: 2, // Adjust spread radius
                    blurRadius: 5, // Adjust blur radius
                    offset: Offset(0, 2), // Adjust offset
                  )
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Notices",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckRequest(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20), backgroundColor: Colors.white, // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5, // Add elevation for shadow
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'asset/Icons/SVG/req-svgrepo-com.svg',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Check Request",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20), backgroundColor: Colors.white, // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5, // Add elevation for shadow
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'asset/Icons/SVG/map-svgrepo-com.svg',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Disposal Place",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DriverComplain(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20), backgroundColor: Colors.white, // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5, // Add elevation for shadow
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'asset/Icons/SVG/complain-ecommerce-market-svgrepo-com.svg',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Add Complain",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
