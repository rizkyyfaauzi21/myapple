import 'dart:convert';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HistoryService {
  final String baseUrl;

  HistoryService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchAppleHistories(String appleId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/appleHistories?apple_id=$appleId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        // Debug log untuk memverifikasi data
        print('Full Response: $responseData');
        
        // Ambil data dari nested structure
        if (responseData['data']?['data'] is List) {
          final List<dynamic> histories = responseData['data']['data'];
          return List<Map<String, dynamic>>.from(histories);
        } else {
          print('Invalid data structure in response');
          return [];
        }
      } else {
        throw Exception('Failed to fetch histories: ${response.body}');
      }
    } catch (e) {
      print('Error in fetchAppleHistories: $e');
      throw Exception('Error: $e');
    }
  }
}

final historyServiceProvider = Provider<HistoryService>((ref) {
  return HistoryService(baseUrl: ApiConfig.baseApiUrl);
});

class AppleHistoryState {
  final List<Map<String, dynamic>> histories;
  final bool isLoading;
  final String? error;

  AppleHistoryState({
    this.histories = const [],
    this.isLoading = false,
    this.error,
  });

  AppleHistoryState copyWith({
    List<Map<String, dynamic>>? histories,
    bool? isLoading,
    String? error,
  }) {
    return AppleHistoryState(
      histories: histories ?? this.histories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final appleHistoryProvider = StateNotifierProvider.family<AppleHistoryNotifier, AppleHistoryState, String>(
  (ref, appleId) => AppleHistoryNotifier(ref.read(historyServiceProvider), appleId),
);

class AppleHistoryNotifier extends StateNotifier<AppleHistoryState> {
  final HistoryService _service;
  final String appleId;

  AppleHistoryNotifier(this._service, this.appleId) : super(AppleHistoryState()) {
    fetchHistories();
  }

  Future<void> fetchHistories() async {
    state = state.copyWith(isLoading: true);
    try {
      final histories = await _service.fetchAppleHistories(appleId);
      state = state.copyWith(
        histories: histories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}


