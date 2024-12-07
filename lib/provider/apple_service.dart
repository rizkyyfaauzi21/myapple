import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// Define the AppleService class
class AppleService {
  final String baseUrl;

  AppleService({required this.baseUrl});

  // Method to add a new apple
  Future<void> addApple({
    required String name,
    required BuildContext context,
    required XFile imagePath,
    required String userId,
  }) async {
    final uri = Uri.parse('$baseUrl/apples');
    final request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = userId
      ..fields['nama_apel'] = name;

    // Attach the image file
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_path',
        imagePath.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    

    // Add authorization header if needed
    request.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';

    final streamedResponse = await request.send();

    // Handle response
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      // Success
      print('Apple added successfully: ${response.body}');
    } else {
      // Error handling
      final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to add apple: $error');
    }
  }
}

// Define the Riverpod provider for AppleService
final appleServiceProvider = Provider<AppleService>((ref) {
  const baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your API base URL
  return AppleService(baseUrl: baseUrl);
});
