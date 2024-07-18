import 'package:ecotrack/style/button.dart';
import 'package:ecotrack/style/text.dart';
import 'package:flutter/material.dart';

class DriverComplain extends StatefulWidget {
  const DriverComplain({Key? key}) : super(key: key);

  @override
  State<DriverComplain> createState() => _DriverComplainState();
}

class _DriverComplainState extends State<DriverComplain> {
  final TextEditingController _complainController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _complainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Complain",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _complainController,
                minLines: 1,
                maxLines: 2,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your complaint',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your complaint';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is validated, you can proceed with your logic here.
                  String complaint = _complainController.text;
                  // Perform action with the complaint
                  print('Complaint submitted: $complaint');
                }
              },
              style: mainButtton,
              child: const Text("Send",style: MainbuttonText,),
            )
          ],
        ),
      ),
    );
  }
}
