import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/provider/history_service.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:apple_leaf/widgets/history/list_penyakit_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apple_leaf/provider/auth_provider.dart';

class ListPenyakitPage extends ConsumerStatefulWidget {
  final String label;
  final String appleId;

  const ListPenyakitPage({
    super.key,
    required this.label,
    required this.appleId,
  });

  @override
  ConsumerState<ListPenyakitPage> createState() => _ListPenyakitPageState();
}

class _ListPenyakitPageState extends ConsumerState<ListPenyakitPage> {
  final searchController = TextEditingController();
  String selectedCategory = 'All'; // Default category
  String searchQuery = '';

  final List<String> categories = ['All', 'Healthy', 'Scab', 'Rust'];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<dynamic> filterHistories(List<dynamic> histories) {
    return histories.where((history) {
      final historyData = history['history'] as Map<String, dynamic>;
      final diseaseInfo = historyData['disease_info'] as Map<String, dynamic>;
      final category = diseaseInfo['category']?.toString().toLowerCase() ?? '';
      final searchLower = searchQuery.toLowerCase();

      bool matchesCategory = selectedCategory == 'All' ||
          category == selectedCategory.toLowerCase();
      bool matchesSearch = category.contains(searchLower) ||
          historyData['scan_date'].toString().toLowerCase().contains(searchLower);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(appleHistoryProvider(widget.appleId));

    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: customAppBar(
        context,
        title: widget.label,
        actions: [
          IconButton(
            onPressed: () => handleDeleteApel(context, ref),
            icon: const Icon(IconsaxPlusLinear.trash),
            color: redBase,
          )
        ],
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomTextField(
                  prefixIcon: IconsaxPlusLinear.search_normal_1,
                  hint: 'Cari riwayat',
                  controller: searchController,
                ),
                const SizedBox(height: 12),
                // Category filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          backgroundColor: neutral50,
                          selectedColor: green100,
                          checkmarkColor: green700,
                          labelStyle: TextStyle(
                            color: selectedCategory == category
                                ? green700
                                : neutral400,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // List view
          Expanded(
            child: historyState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : historyState.error != null
                    ? Center(child: Text(historyState.error!))
                    : historyState.histories.isEmpty
                        ? const Center(child: Text('Belum ada riwayat'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount:
                                filterHistories(historyState.histories).length,
                            itemBuilder: (context, index) {
                              final history =
                                  filterHistories(historyState.histories)[index];
                              final historyData =
                                  history['history'] as Map<String, dynamic>;
                              final diseaseInfo = historyData['disease_info']
                                  as Map<String, dynamic>;

                              return ListPenyakitCard(
                                image: historyData['scan_image_path'] ??
                                    'assets/images/daun_article.png',
                                title: diseaseInfo['category'] ??
                                    'Unknown Disease',
                                date: historyData['scan_date'] ?? '-',
                                description: diseaseInfo['description'] ?? '-',
                                symptom: diseaseInfo['symptoms'] ?? '-',
                                solution: diseaseInfo['treatment'] ?? '-',
                                historyId: history['id'],
                                appleId: widget.appleId,
                              );
                            },
                          ),
          )
        ],
      ),
    );
  }

  Future<void> handleDeleteApel(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Hapus riwayat ini?',
        subtitle:
            'Semua informasi yang terkait dengan diagnosis ini akan hilang.',
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  isDialogButton: true,
                  text: 'Hapus',
                  backgroundColor: redBase,
                  onTap: () async {
                    try {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      final appleService = ref.read(appleServiceProvider);
                      final userId = ref.read(authProvider).userData?['id'].toString();
                      
                      // Delete the apple
                      await appleService.deleteApple(widget.appleId);
                      
                      // Refresh states
                      if (userId != null) {
                        // Refresh apple list
                        ref.read(appleProvider(userId).notifier).fetchApples();
                        // Invalidate history state
                        ref.refresh(appleHistoryProvider(widget.appleId));
                      }

                      if (context.mounted) {
                        // Hide loading indicator
                        Navigator.pop(context);
                        // Close dialog
                        Navigator.pop(context);
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Apel berhasil dihapus'),
                            backgroundColor: green700,
                          ),
                        );
                        // Go back to previous page
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        // Hide loading if shown
                        Navigator.pop(context);
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal menghapus apel: $e'),
                            backgroundColor: redBase,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomButton(
                  isDialogButton: true,
                  text: 'Batal',
                  backgroundColor: neutralWhite,
                  borderColor: neutral100,
                  textColor: neutralBlack,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
