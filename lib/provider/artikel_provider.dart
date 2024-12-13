import 'dart:convert';
import 'dart:io';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Artikel state model
class ArtikelState {
  final List articles;
  final bool isLoading;
  final String? errorMessage;

  ArtikelState(
      {this.articles = const [], this.isLoading = true, this.errorMessage});

  ArtikelState copyWith(
      {List? articles, bool? isLoading, String? errorMessage}) {
    return ArtikelState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Artikel Provider
final artikelProvider =
    StateNotifierProvider<ArtikelNotifier, ArtikelState>((ref) {
  return ArtikelNotifier();
});

// State Notifier untuk mengelola artikel
class ArtikelNotifier extends StateNotifier<ArtikelState> {
  ArtikelNotifier() : super(ArtikelState()) {
    fetchArticles();
  }

  final baseUrl = ApiConfig.baseApiUrl;

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/articles'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = state.copyWith(
          articles: data['data'] ?? [],
          isLoading: false,
          errorMessage: null,
        );
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
