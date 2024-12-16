import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/artikel/artikel_card.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/artikel_provider.dart';

class ArtikelPage extends ConsumerStatefulWidget {
  const ArtikelPage({super.key});

  @override
  ConsumerState<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends ConsumerState<ArtikelPage> {
  @override
  void initState() {
    super.initState();
    // Refresh articles when page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(artikelProvider.notifier).fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final artikelState = ref.watch(artikelProvider);
    final artikelNotifier = ref.read(artikelProvider.notifier);

    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: mainAppBar(context, title: 'Artikel'),
      body: RefreshIndicator(
        onRefresh: () async {
          await artikelNotifier.fetchArticles();
        },
        child: artikelState.isLoading
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
                : artikelState.articles.isEmpty
                    ? const Center(
                        child: Text(
                          'Artikel belum tersedia',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
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
                            articleId: article['id'],
                          );
                        },
                      ),
      ),
    );
  }
}