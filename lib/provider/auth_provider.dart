// File: lib/providers/auth_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthState {
  final bool isLoading;
  final String? token;
  final String? error;
  final Map<String, dynamic>? userData;

  AuthState({
    this.isLoading = false,
    this.token,
    this.error,
    this.userData,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _loadUserData();
  }

  final _storage = const FlutterSecureStorage();
  final String baseUrl = 'http://192.168.1.4:8000/api'; // Replace with your server IP

  Future<void> _loadUserData() async {
    final token = await _storage.read(key: 'auth_token');
    if (token != null) {
      await fetchUserData(token: token);
    }
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      state = AuthState(error: 'Email dan Password tidak boleh kosong.');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = AuthState(error: 'Format email tidak valid.');
      return;
    }

    state = AuthState(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['data']['token'];
        final userData = data['data']['user'];
        await _storage.write(key: 'auth_token', value: token);

        state = AuthState(token: token, userData: userData);
      } else {
        final data = jsonDecode(response.body);
        state = AuthState(error: data['message'] ?? 'Email atau Password salah.');
      }
    } catch (e) {
      print('Login Error: $e');
      state = AuthState(error: 'Gagal terhubung ke server.');
    }
  }

  Future<void> fetchUserData({String? token}) async {
      try {
        token ??= await _storage.read(key: 'auth_token');
        if (token == null) {
          state = AuthState(error: 'Token tidak ditemukan. Silakan login kembali.');
          return;
        }

        final response = await http.get(
          Uri.parse('$baseUrl/user'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer' ,
          },
        );

        print('Fetch User Data Response: ${response.statusCode}');
        print('Response body: "${response.body}"');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final userData = data['data'];
          state = AuthState(userData: userData, token: token);
        } else {
          state = AuthState(error: 'Gagal mengambil data user.');
        }
      } catch (e) {
        print('Fetch User Data Error: $e');
        state = AuthState(error: 'Gagal terhubung ke server.');
      }
    }

  Future<void> register(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      state = AuthState(error: 'Semua kolom harus diisi.');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = AuthState(error: 'Format email tidak valid.');
      return;
    }

    state = AuthState(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: "${response.body}"');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Handle successful registration
        state = AuthState();
      } else {
        final data = jsonDecode(response.body);
        state = AuthState(error: data['message'] ?? 'Terjadi kesalahan.');
      }
    } catch (e, stackTrace) {
      print('Register Error: $e');
      print('Stack Trace: $stackTrace');
      state = AuthState(error: 'Gagal terhubung ke server.');
    }
  }

  Future<void> logout() async {
    state = AuthState(isLoading: true);
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
      await _storage.delete(key: 'auth_token');
      state = AuthState();
    } catch (e) {
      print('Logout Error: $e');
      state = AuthState(error: 'Gagal logout.');
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        return 'Token tidak ditemukan. Silakan login kembali.';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
      );

      print('Update Profile Response: ${response.statusCode}');
      print('Response body: "${response.body}"');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['data'];
        state = AuthState(userData: userData, token: token);
        return null;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Gagal memperbarui profil.';
      }
    } catch (e) {
      print('Update Profile Error: $e');
      return 'Gagal terhubung ke server.';
    }
  }

  Future<String?> updatePassword(String password) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        return 'Token tidak ditemukan. Silakan login kembali.';
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/user/password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'password': password,
          'password_confirmation': password,
        }),
      );

      print('Update Password Response: ${response.statusCode}');
      print('Response body: "${response.body}"');

      if (response.statusCode == 200) {
        return null;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Gagal memperbarui password.';
      }
    } catch (e) {
      print('Update Password Error: $e');
      return 'Gagal terhubung ke server.';
    }
  }
}