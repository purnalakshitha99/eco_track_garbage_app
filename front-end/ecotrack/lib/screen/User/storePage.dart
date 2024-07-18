import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/User/storePageDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StorePage extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const StorePage({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late List<Map<String, dynamic>> _storeData = [];

  @override
  void initState() {
    super.initState();
    _fetchStoreData();
  }

  Future<void> _fetchStoreData() async {
    final response = await http.get(
      Uri.parse('$localhost/users/store_items'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _storeData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to fetch store items with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Store",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        leading: null,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 2 / 3, // Adjust the ratio as needed
        ),
        itemCount: _storeData.length,
        itemBuilder: (context, index) {
          final item = _storeData[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StorePageDetails(
                      name: item['name'] ?? '',
                      price: item['price'] ?? 0.0,
                      description: item['description'] ?? '',
                      imagePath: item['imagePath'] ?? '', 
                      quantity: item['quantity']?? 0,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 237, 231, 231),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.network(
                        item['imagePath'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              item['name'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            'Rs. ${item['price'] ?? ''}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
