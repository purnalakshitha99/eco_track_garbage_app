import 'dart:convert';
import 'dart:io';

import 'package:ecotrack/ipconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePost extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;
  final int noticeId;

  const UpdatePost({
    Key? key,
    required this.token,
    required this.userDetails,
    required this.noticeId,
  }) : super(key: key);

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  late TextEditingController _descriptionController;
  File? _imageFile; // Initialize as null

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _fetchPreviousData(); // Fetch previous data when the widget initializes
  }

  Future<void> _fetchPreviousData() async {
    final response = await http.get(
      Uri.parse('$localhost/notices2/${widget.noticeId}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _descriptionController.text = data['description'] ?? '';
      });
    } else {
      print('Failed to fetch previous data with status: ${response.statusCode}');
    }
  }

  Future<void> _updateData() async {
    // Update data logic
    // ...

    // After updating data, navigate back to the home page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your UI widgets here
            ElevatedButton(
              onPressed: _updateData,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
