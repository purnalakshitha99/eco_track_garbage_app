import 'package:flutter/material.dart';
import 'package:ecotrack/screen/TruckDriver/Route1.dart';
import 'package:ecotrack/screen/TruckDriver/Route2.dart'; // Import Route2 page

class CheckRequest extends StatefulWidget {
  const CheckRequest({Key? key}) : super(key: key);

  @override
  State<CheckRequest> createState() => _CheckRequestState();
}

class _CheckRequestState extends State<CheckRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Check",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Text(
              "Request",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Route1Page when Route A is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Route1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Route A",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        "75%",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Route1Page when Route A is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Route2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Route B",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        "75%",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Route3Page when Route C is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Route2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Route C",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        "25%",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
