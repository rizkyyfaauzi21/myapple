import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppleNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  AppleNotifier() : super([]);

  Future<void> fetchApples() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/apples'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        state = List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to fetch apples');
      }
    } catch (e) {
      print('Error fetching apples: $e');
    }
  }
}

final appleNotifierProvider =
    StateNotifierProvider<AppleNotifier, List<Map<String, dynamic>>>(
  (ref) => AppleNotifier(),
);