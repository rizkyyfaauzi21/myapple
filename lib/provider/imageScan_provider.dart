import 'dart:convert';
import 'dart:io';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:apple_leaf/pages/history/scan_page.dart';

// Provider untuk fungsi upload gambar
final imageUploadProvider = Provider<ImageUploadService>((ref) {
  return ImageUploadService();
});

// Kelas untuk mengelola upload gambar ke FastAPI
class ImageUploadService {
  Future<Map<String, dynamic>> handleImageUpload(File imageFile, BuildContext context) async {
    try {
      final url = Uri.parse(ApiConfig.predictUrl);
      final mimeType = lookupMimeType(imageFile.path);

      // Validasi mimeType
      if (mimeType == null) {
        throw Exception("Unable to determine MIME type of the file.");
      }

      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath(
          'file', // Sesuai parameter di FastAPI
          imageFile.path,
          contentType: MediaType.parse(mimeType),
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        
        // Decode respons dari JSON
        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        // Validasi dan ekstraksi data yang diperlukan
        if (responseData.containsKey('predicted_label') && responseData.containsKey('category')) {
          final categoryData = responseData['category']['data'];
          
          if (categoryData is List && categoryData.isNotEmpty) {
            // Ambil objek pertama dari data
            final categoryDetails = categoryData[0];

            return {
              'predicted_label': responseData['predicted_label'],
              'category': categoryDetails,
            };
          } else {
            throw Exception("No category data found.");
          }
        } else {
          throw Exception("Invalid response data.");
        }
      } else {
        throw Exception("Failed to upload image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Tampilkan error atau snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      rethrow; // Lempar ulang exception jika terjadi kesalahan
    }
  }
}