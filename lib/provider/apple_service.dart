import 'dart:convert';
import 'dart:io';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

/// **AppleService**
/// Kelas ini menangani interaksi dengan API untuk operasi terkait apel.
class AppleService {
  final String baseUrl;

  AppleService({required this.baseUrl});

  /// **addApple**
  /// Menambahkan apel baru ke server.
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

    // Lampirkan file gambar
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_path',
        imagePath.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    // Tambahkan header jika perlu (contoh: Bearer token)
    request.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';

    // Kirim permintaan
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      print('Apple added successfully: ${response.body}');
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to add apple: $error');
    }
  }

  /// **fetchApplesByUser**
  /// Mengambil daftar apel untuk pengguna tertentu.
  Future<List<Map<String, dynamic>>> fetchApplesByUser(String userId) async {
    final uri = Uri.parse('$baseUrl/users/$userId/apples');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['message'] ?? response.body;
        throw Exception('Error from server: $errorMessage');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e is FormatException) {
        throw Exception('Invalid response format from server.');
      } else {
        throw Exception('Unexpected error: ${e.toString()}');
      }
    }
  }
  
  Future<void> deleteApple(String appleId) async {
    final uri = Uri.parse('$baseUrl/apples/$appleId');
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print('Apple deleted successfully: ${response.body}');
    }
  }
}

/// **Provider untuk AppleService**
final appleServiceProvider = Provider<AppleService>((ref) {
  const baseUrl = ApiConfig.baseApiUrl; // Ganti dengan URL API Anda
  return AppleService(baseUrl: baseUrl);
});

/// **AppleState**
/// Model untuk merepresentasikan state daftar apel.
class AppleState {
  final List<Map<String, dynamic>> apples;
  final bool isLoading;
  final String? errorMessage;

  AppleState({
    this.apples = const [],
    this.isLoading = true,
    this.errorMessage,
  });

  AppleState copyWith({
    List<Map<String, dynamic>>? apples,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AppleState(
      apples: apples ?? this.apples,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// **Provider untuk AppleState**
/// Menyediakan state daftar apel berdasarkan `userId`.
final appleProvider =
    StateNotifierProvider.family<AppleNotifier, AppleState, String>(
  (ref, userId) {
    final appleService = ref.watch(appleServiceProvider);
    return AppleNotifier(appleService: appleService, userId: userId);
  },
);

/// **AppleNotifier**
/// Mengelola state daftar apel dan operasi terkait.
class AppleNotifier extends StateNotifier<AppleState> {
  final AppleService appleService;
  final String userId;

  AppleNotifier({required this.appleService, required this.userId})
      : super(AppleState()) {
    fetchApples();
  }

  /// Mengambil daftar apel dari API.
  Future<void> fetchApples() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final apples = await appleService.fetchApplesByUser(userId);
      state = state.copyWith(apples: apples, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Menambahkan apel baru ke state setelah berhasil ditambahkan ke server.
  Future<void> addApple({
    required String name,
    required BuildContext context,
    required XFile imagePath,
  }) async {
    try {
      await appleService.addApple(
        name: name,
        context: context,
        imagePath: imagePath,
        userId: userId,
      );

      // Setelah sukses, tambahkan apel baru ke state
      fetchApples();
    } catch (e) {
      throw Exception('Failed to add apple: $e');
    }
  }
  Future<void> deleteApple(String appleId) async {
    await appleService.deleteApple(appleId);
    fetchApples();
  }
}
