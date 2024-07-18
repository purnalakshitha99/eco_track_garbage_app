import 'dart:convert';

import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/User/ReportViewer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportGeneration extends StatelessWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const ReportGeneration(
      {Key? key, required this.token, required this.userDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _generateReport(context, 'pdf'); // Example: Generate PDF report
              },
              child: Text('Generate PDF Report'),
            ),
            ElevatedButton(
              onPressed: () {
                _generateReport(
                    context, 'html'); // Example: Generate HTML report
              },
              child: Text('Generate HTML Report'),
            ),
            // Add more options for report formats as needed
          ],
        ),
      ),
    );
  }

  void _generateReport(BuildContext context, String format) async {
    try {
      final response = await http.get(
        Uri.parse('$localhost/report/$format'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          'VERSION': 'V1', // Add VERSION header with value V1
        },
      );

      if (response.statusCode == 200) {
        // Report generation successful
        // Check if the response contains the report data or a URL to the report file
        // For example, if the response is JSON data containing the report content:
        // final Map<String, dynamic> responseData = json.decode(response.body);
        // final String reportData = responseData['report'];

        // If the response is a URL to the generated report file:
        final String reportUrl = response.body;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportViewer(reportUrl: reportUrl),
          ),
        );

        // Display the generated report using a WebView or a PDF viewer widget
        // For example, if displaying a PDF report:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PdfViewerPage(pdfUrl: reportUrl),
        //   ),
        // );

        // In this example, we're just showing a success message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report generated successfully in $format format'),
          ),
        );
      } else {
        // Report generation failed
        // Display an error message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate report'),
          ),
        );
      }
    } catch (e) {
      // Error occurred during report generation
      // Display an error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating report: $e'),
        ),
      );
    }

    // Close the ReportGeneration screen
    Navigator.pop(context);
  }
}
