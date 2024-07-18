import 'package:flutter/material.dart';

class RquestPage extends StatefulWidget {
  const RquestPage({super.key});

  @override
  State<RquestPage> createState() => _RquestPageState();
}

class _RquestPageState extends State<RquestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request"),
        
      ),
    );
  }
}