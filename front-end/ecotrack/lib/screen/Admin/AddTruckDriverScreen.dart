import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TruckDriver {
  final String name;
  final String licenceNumber;
  final String phone;
  final String nic;
  final int age;
  final String password;
  final String email;

  TruckDriver({
    required this.name,
    required this.licenceNumber,
    required this.phone,
    required this.nic,
    required this.age,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'licenceNumber': licenceNumber,
      'phone': phone,
      'nic': nic,
      'age': age,
      'password': password,
      'email': email,
    };
  }
}

class AddTruckDriverScreen extends StatefulWidget {
  final String? token;

  const AddTruckDriverScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<AddTruckDriverScreen> createState() => _AddTruckDriverScreenState();
}

class _AddTruckDriverScreenState extends State<AddTruckDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _licenceNumberController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nicController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> _addTruckDriver(BuildContext context) async {
    final truckDriverData = TruckDriver(
      name: _nameController.text,
      licenceNumber: _licenceNumberController.text,
      phone: _phoneController.text,
      nic: _nicController.text,
      age: int.parse(_ageController.text),
      password: _passwordController.text,
      email: _emailController.text,
    );

    final jsonBody = truckDriverData.toJson();

    try {
      final response = await http.post(
        Uri.parse('$localhost/truckdriver'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
          'VERSION': 'V1',
        },
        body: json.encode(jsonBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Truck driver added successfully!'),
              actions: <Widget>[
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
      } else {
        // Show error alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to add truck driver!'),
              actions: <Widget>[
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
    } catch (e) {
      // Handle exceptions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An unexpected error occurred!'),
            actions: <Widget>[
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Truck Driver'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _licenceNumberController,
                decoration: InputDecoration(labelText: 'Licence Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your licence number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nicController,
                decoration: InputDecoration(labelText: 'NIC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your NIC';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTruckDriver(context); // Send data to backend
                  }
                },
                child: Text('Add Truck Driver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
