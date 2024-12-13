import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final Map<int, String> diseaseNames = {
  1: 'Scab',
  2: 'Rust',
  3: 'Healthy',
};

final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  return HistoryNotifier();
});

// History state model
class HistoryState {
  final List<History> histories;
  final bool isLoading;
  final String? errorMessage;
  final int totalPages;

  HistoryState({
    this.histories = const [],
    this.isLoading = false,
    this.errorMessage,
    this.totalPages = 0,
  });

  HistoryState copyWith({
    List<History>? histories,
    bool? isLoading,
    String? errorMessage,
    int? totalPages,
  }) {
    return HistoryState(
      histories: histories ?? this.histories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

// History model
class History {
  final int? id;
  final int? userId;
  final int? diseaseInfoId;
  final String scanImagePath;
  final DateTime scanDate;

  History({
    this.id,
    this.userId,
    this.diseaseInfoId,
    required this.scanImagePath,
    required this.scanDate,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      userId: json['user_id'],
      diseaseInfoId: json['disease_info_id'],
      scanImagePath: json['scan_image_path'] ?? '',
      scanDate: DateTime.parse(json['scan_date'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'disease_info_id': diseaseInfoId,
      'scan_image_path': scanImagePath,
      'scan_date': scanDate.toIso8601String(),
    };
  }
}

// History response model for pagination data
class HistoryResponse {
  final bool success;
  final String message;
  final HistoryData data;

  HistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      success: json['success'],
      message: json['message'],
      data: HistoryData.fromJson(json['data']),
    );
  }
}

// History data model for pagination
class HistoryData {
  final int currentPage;
  final List<History> histories;
  final int totalPages;

  HistoryData({
    required this.currentPage,
    required this.histories,
    required this.totalPages,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    var historiesList = json['data'] as List;
    List<History> histories =
        historiesList.map((history) => History.fromJson(history)).toList();

    return HistoryData(
      currentPage: json['current_page'],
      histories: histories,
      totalPages: json['last_page'],
    );
  }
}

// History notifier class to fetch data
class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier() : super(HistoryState()) {
    _init();
  }

  final String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  Future<void> _init() async {
    await fetchHistories();
  }

  Future<void> fetchHistories() async {
    try {
      state = state.copyWith(isLoading: true);

      final response = await http.get(Uri.parse('$baseUrl/histories'));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        if (decodedData['success'] == true && decodedData['data'] != null) {
          final paginationData = decodedData['data'];
          final List<dynamic> historiesData = paginationData['data'];

          final List<History> histories = historiesData
              .map<History>((data) => History.fromJson(data))
              .toList();

          state = state.copyWith(
            histories: histories,
            isLoading: false,
            errorMessage: null,
            totalPages: paginationData['last_page'] ?? 1,
          );
        } else {
          throw Exception(decodedData['message'] ?? 'Failed to parse data');
        }
      } else {
        throw Exception('Failed to load histories');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        histories: [],
      );
    }
  }
}
