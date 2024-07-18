import 'dart:io';
import 'package:ecotrack/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPost extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;
  const AdminPost({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<AdminPost> createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  late TextEditingController _descriptionController;
  late File? _imageFile;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _imageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : const Icon(Icons.image), // Placeholder for image display
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _uploadData();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    if (_imageFile == null) {
      return; // No image selected
    }

    // Create multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$localhost/notices2'), // Replace with your actual endpoint
    );

    // Add image file to the request
    var imageFile = await http.MultipartFile.fromPath(
      'imagePath',
      _imageFile!.path,
    );
    request.files.add(imageFile);

    // Add description to the request
    request.fields['description'] = _descriptionController.text;

    // Add token to the request headers
    request.headers['Authorization'] = 'Bearer ${widget.token}';

    // Send the request
    var response = await request.send();

    // Check the response
    if (response.statusCode == 200) {
      // Clear fields after successful submission
      setState(() {
        _imageFile = null;
        _descriptionController.clear();
      });
      // Show success alert
      _showSuccessDialog();
    } else {
      // Handle errors
      print('Error uploading data: ${response.reasonPhrase}');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Post submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
