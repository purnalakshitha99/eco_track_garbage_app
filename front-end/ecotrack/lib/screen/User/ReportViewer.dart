import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ReportViewer extends StatefulWidget {
  final String reportUrl;

  const ReportViewer({Key? key, required this.reportUrl}) : super(key: key);

  @override
  _ReportViewerState createState() => _ReportViewerState();
}

class _ReportViewerState extends State<ReportViewer> {
  String? _localFilePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
   
  }


  Future<void> _downloadAndOpenFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final fileName = url.split('/').last;
    final file = File('${documentDirectory.path}/$fileName');

    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      _localFilePath = file.path;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Downloading Report')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_localFilePath == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Failed to download the report')),
      );
    }

    if (_localFilePath!.endsWith('.pdf')) {
      return Scaffold(
        appBar: AppBar(title: Text('Report (PDF)')),
        body: PDFView(filePath: _localFilePath!),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Unsupported File Format')),
        body: Center(child: Text('The file format is not supported')),
      );
    }
  }
}
