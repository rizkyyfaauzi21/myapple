import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/artikel/artikel_card.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/artikel_provider.dart';

class ArtikelPage extends ConsumerWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artikelState = ref.watch(artikelProvider);
    final artikelNotifier = ref.read(artikelProvider.notifier);

    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: mainAppBar(context, title: 'Artikel'),
      body: artikelState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : artikelState.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${artikelState.errorMessage}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: artikelNotifier.fetchArticles,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: artikelState.articles.length,
                  itemBuilder: (context, index) {
                    final article = artikelState.articles[index];

                    return ArtikelCard(
                      image_path: article['image_url'] ?? 'assets/images/default_image.png',
                      label: article['source'] ?? 'Uncategorized',
                      title: article['title'] ?? 'Untitled',
                      content: article['content'] ?? 'No content',
                      articleId: article['id'], // Mengirimkan ID artikel
                    );
                  },
                ),
    );
  }
}
