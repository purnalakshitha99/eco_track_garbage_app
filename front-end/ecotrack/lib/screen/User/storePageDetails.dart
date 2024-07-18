import 'package:flutter/material.dart';

class StorePageDetails extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String imagePath;

  const StorePageDetails({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Name: $name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Price: $price',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Quantity: $quantity',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Description: $description',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your buy now functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white,fontSize: 20), // Text color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
