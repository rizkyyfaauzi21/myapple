import 'dart:convert';
import 'dart:io';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class ScanNotifier extends StateNotifier<void> {
  ScanNotifier() : super(null);
  final baseUrl = ApiConfig.baseApiUrl;
  Future<void> saveDiagnosis({
    required String appleId,
    required String userId,
    required String scanDate,
    required String imagePath,
    required String diseaseInfoId,
  }) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/histories'),
      );

      // Add headers
      request.headers['Accept'] = 'application/json';

      // Add text fields
      request.fields['scan_date'] = scanDate;
      request.fields['user_id'] = userId;
      request.fields['disease_info_id'] = diseaseInfoId;

      // Get file extension
      final extension = imagePath.split('.').last.toLowerCase();

      // Create file stream
      final file = File(imagePath);
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();

      // Add file with proper content type
      var multipartFile = http.MultipartFile(
        'scan_image_path',
        stream,
        length,
        filename: basename(imagePath),
        contentType: MediaType('image', extension),
      );
      request.files.add(multipartFile);

      // Send request
      var historyResponse = await request.send();
      var responseData = await historyResponse.stream.bytesToString();

      final historyId = jsonDecode(responseData)['data']['id'];

      // Simpan ke apple_history
      final appleHistoryResponse = await http.post(
        Uri.parse('$baseUrl/appleHistories'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'apple_id': appleId,
          'history_id': historyId.toString(),
        }),
      );

      if (appleHistoryResponse.statusCode != 200) {
        throw Exception(
          'Failed to save apple history: ${appleHistoryResponse.statusCode} - ${appleHistoryResponse.body}',
        );
      }

      print('Diagnosis saved successfully');
    } catch (e) {
      print('Error saving diagnosis: $e');
      rethrow;
    }
  }
}

final scanNotifierProvider =
    StateNotifierProvider<ScanNotifier, void>((ref) => ScanNotifier());
