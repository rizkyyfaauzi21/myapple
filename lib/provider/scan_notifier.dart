import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ScanNotifier extends StateNotifier<void> {
  ScanNotifier() : super(null);

  Future<void> saveDiagnosis({
    required String appleId,
    required String userId,
    required String scanDate,
    required File scanImagePath,
    required String diseaseInfoId,
  }) async {
    try {
      // Simpan history
      final historyResponse = await http.post(
        Uri.parse('http://192.168.43.147:8000/api/history'),
        body: {
          'user_id': userId,
          'scan_date': scanDate,
          'scan_image_path': scanImagePath.path,
          'disease_info_id': diseaseInfoId,
        },
      );

      if (historyResponse.statusCode != 201) {
        throw Exception('Failed to save history');
      }

      final historyId = jsonDecode(historyResponse.body)['data']['id'];

      // Simpan ke apple_history
      final appleHistoryResponse = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/apple-history'),
        body: {
          'apple_id': appleId,
          'history_id': historyId,
        },
      );

      if (appleHistoryResponse.statusCode != 201) {
        throw Exception('Failed to save apple history');
      }

      print('Diagnosis saved successfully');
    } catch (e) {
      print('Error saving diagnosis: $e');
    }
  }
}

final scanNotifierProvider =
    StateNotifierProvider<ScanNotifier, void>((ref) => ScanNotifier());
