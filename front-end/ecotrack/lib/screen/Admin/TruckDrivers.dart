import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/Admin/TruckDriversAdd.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TruckDriver {
  final int id;
  final String name;
  final String licenceNumber;
  final String phone;
  final String nic;
  final int age;
  final String password;
  final String email;

  TruckDriver({
    required this.id,
    required this.name,
    required this.licenceNumber,
    required this.phone,
    required this.nic,
    required this.age,
    required this.password,
    required this.email,
  });

  factory TruckDriver.fromJson(Map<String, dynamic> json) {
    return TruckDriver(
      id: json['id'] as int,
      name: json['name'] as String,
      licenceNumber: json['licenceNumber'] as String,
      phone: json['phone'] as String,
      nic: json['nic'] as String,
      age: json['age'] as int,
      password: json['password'] as String,
      email: json['email'] as String,
    );
  }
}

class TruckDrivers extends StatefulWidget {
   final String? token;
  final Map<String, dynamic>? userDetails;
  const TruckDrivers({Key? key, required this.token, required this.userDetails}) : super(key: key);


  @override
  State<TruckDrivers> createState() => _TruckDriversState();
}

class _TruckDriversState extends State<TruckDrivers> {
  List<TruckDriver> truckDrivers = [];

  @override
  void initState() {
    super.initState();
    fetchTruckDrivers();
  }

  Future<void> fetchTruckDrivers() async {
    final apiUrl = '$localhost/truckdriver';

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
          truckDrivers = responseData
              .map((driver) => TruckDriver.fromJson(driver))
              .toList();
        });
      } else {
        print('Failed to fetch truck drivers data with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _deleteTruckDriver(int driverId) async {
    final apiUrl = '$localhost/truckdriver/$driverId';

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
        fetchTruckDrivers(); // Refresh the list of truck drivers after deletion
      } else {
        print('Failed to delete truck driver with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _editTruckDriver(TruckDriver driver) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTruckDriverScreen(
          token: widget.token,
          userDetails: widget.userDetails,
          truckDriver: driver, // Pass the selected truck driver's data
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck Drivers'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>TruckDRiversAdd(token: widget.token,userDetails:widget.userDetails ,)));
            }, icon: const Icon(Icons.add_box_rounded,size: 40,)),
          )
        ],
      ),
      body: Center(
        child: truckDrivers.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: truckDrivers.length,
                itemBuilder: (context, index) {
                  final driver = truckDrivers[index];
                  return Card(
                    child: ListTile(
                      title: Text(driver.name),
                      subtitle: Text('Licence Number: ${driver.licenceNumber}\nPhone: ${driver.phone}\nNIC: ${driver.nic}\nAge: ${driver.age}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              _editTruckDriver(driver); // Pass the selected truck driver's data to edit
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteTruckDriver(driver.id); // Delete the truck driver
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // You can also handle tap on the entire list tile
                        // This can be useful if you want to navigate to a detailed view of the driver
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class AddTruckDriverScreen extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;
  final TruckDriver? truckDriver;

  const AddTruckDriverScreen({Key? key, required this.token, required this.userDetails, this.truckDriver}) : super(key: key);

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
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.truckDriver != null) { // Check if truck driver details are provided
      _nameController.text = widget.truckDriver!.name;
      _licenceNumberController.text = widget.truckDriver!.licenceNumber;
      _phoneController.text = widget.truckDriver!.phone;
      _nicController.text = widget.truckDriver!.nic;
      _ageController.text = widget.truckDriver!.age.toString();
      _emailController.text = widget.truckDriver!.email;
    }
  }

  Future<void> _addOrUpdateTruckDriver() async {
    // Implement add or update functionality based on whether truck driver data is provided
    // Use _formKey.currentState.validate() to validate form fields
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.truckDriver != null ? 'Edit Truck Driver' : 'Add Truck Driver'),
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
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addOrUpdateTruckDriver(); // Call function to add or update truck driver
                  }
                },
                child: Text(widget.truckDriver != null ? 'Update Truck Driver' : 'Add Truck Driver'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TruckDRiversAdd(token: widget.token, userDetails: widget.userDetails),
      ),
    );
  },
  child: Icon(Icons.add),
),

    );
  }
}
