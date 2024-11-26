import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  AuthState copyWith({
    bool? isLoading,
    String? token,
    String? error,
    Map<String, dynamic>? userData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error ?? this.error,
      userData: userData ?? this.userData,
    );
  }
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
      state = state.copyWith(error: 'Email dan Password tidak boleh kosong.');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = state.copyWith(error: 'Format email tidak valid.');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['data']['token'];
        final userData = data['data']['user'];
        await _storage.write(key: 'auth_token', value: token);

        state = state.copyWith(token: token, userData: userData, isLoading: false);
      } else {
        final data = jsonDecode(response.body);
        state = state.copyWith(
          error: data['message'] ?? 'Email atau Password salah.',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: 'Gagal terhubung ke server.', isLoading: false);
    }
  }

  Future<void> fetchUserData({String? token}) async {
    try {
      token ??= await _storage.read(key: 'auth_token');
      if (token == null) {
        state = state.copyWith(error: 'Token tidak ditemukan. Silakan login kembali.');
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['data'];
        state = state.copyWith(userData: userData, token: token);
      } else {
        state = state.copyWith(error: 'Gagal mengambil data user.');
      }
    } catch (e) {
      state = state.copyWith(error: 'Gagal terhubung ke server.');
    }
  }

  Future<void> register(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      state = state.copyWith(error: 'Semua kolom harus diisi.');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = state.copyWith(error: 'Format email tidak valid.');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

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

      if (response.statusCode == 201) {
        // After successful registration, log the user in
        await login(email, password);
      } else {
        final data = jsonDecode(response.body);
        state = state.copyWith(
          error: data['message'] ?? 'Terjadi kesalahan.',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: 'Gagal terhubung ke server.', isLoading: false);
    }
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'auth_token');
      state = AuthState(); // Reset the authentication state
    } catch (e) {
      state = state.copyWith(error: 'Gagal logout.');
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['data'];
        // Update the state with the new user data
        state = state.copyWith(userData: userData);
        return null; // No error
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        final errors = data['errors'];
        String errorMessage = 'Gagal memperbarui profil.';
        if (errors != null && errors.isNotEmpty) {
          errorMessage = errors.values.first[0];
        }
        return errorMessage;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Gagal memperbarui profil.';
      }
    } catch (e) {
      return 'Gagal terhubung ke server.';
    }
  }
}
