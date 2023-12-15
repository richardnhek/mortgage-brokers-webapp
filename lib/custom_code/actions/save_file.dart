// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<void> saveFile(String? filePath) async {
  var client;
  if (filePath == null || filePath.isEmpty) {
    throw 'File path cannot be null or empty';
  }

  try {
    // Create an HTTP client
    client = http.Client();

    // Make a request to download the file
    var response = await client.get(Uri.parse(filePath));

    if (response.statusCode == 200) {
      // Create a Blob from the file's content
      final blob = html.Blob([response.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", filePath.split('/').last)
        ..click();

      // Cleanup: Revoke the object URL after use
      html.Url.revokeObjectUrl(url);
    } else {
      throw 'Failed to download file: Server responded with status code ${response.statusCode}';
    }
  } catch (e) {
    throw 'An error occurred while downloading the file: $e';
  } finally {
    client.close();
  }
}
