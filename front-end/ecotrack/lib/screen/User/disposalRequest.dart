import 'package:ecotrack/ipconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisposalRequest extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const DisposalRequest({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<DisposalRequest> createState() => _DisposalRequestState();
}

class Item {
  final IconData icon;
  final String name;

  Item({required this.icon, required this.name});
}

class _DisposalRequestState extends State<DisposalRequest> {
  List<String> items = [
    'Polystyrene',
    'Glass',
    'Food',
    'Paper',
    // Add more items as needed
  ];

  List<bool> checkedItems = List<bool>.generate(
    4, // Number of items
    (index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Disposal",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Text(
              "Request",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "Poppins-Bold"),
            ),
          ),
          Container(
            width: 350,
            height: 400,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Add a Request",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "Poppins-Bold"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(items[index]),
                        value: checkedItems[index],
                        onChanged: (value) {
                          setState(() {
                            checkedItems[index] = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _sendRequest,
                      child: const Text(
                        'Send Request',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _sendRequest() async {
    String? userEmail = widget.userDetails?['email'];
    String? userId = widget.userDetails?['id']?.toString(); // Convert userId to string

    if (userEmail != null && userId != null) {
      List<String> selectedItems = [];
      for (int i = 0; i < checkedItems.length; i++) {
        if (checkedItems[i]) {
          selectedItems.add(items[i]);
        }
      }

      if (selectedItems.isEmpty) {
        // Show an error message or handle the case where no items are selected
        return;
      }

      Map<String, dynamic> requestBody = {
        'user_id': userId,
        'user_email': userEmail,
        'selected_items': selectedItems,
      };

      try {
        final response = await http.post(
          Uri.parse('$localhost/request/user/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${widget.token}',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          // Request successful
          // Handle success response
          print('Request sent successfully');
        } else {
          // Request failed
          // Handle failure response
          print('Failed to send request: ${response.body}');
        }
      } catch (e) {
        // Handle network or other errors
        print('Error sending request: $e');
      }
    }
  }
}
