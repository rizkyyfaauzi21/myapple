import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/pages/history/list_penyakit_page.dart';
import '../../provider/auth_provider.dart'; // Add this import

class RiwayatPage extends ConsumerStatefulWidget {
  const RiwayatPage({super.key});

  @override
  ConsumerState<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends ConsumerState<RiwayatPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProvider).userData?['id']?.toString() ?? '';
    final appleState = ref.watch(appleProvider(userId));

    return Scaffold(
      appBar: mainAppBar(context, title: 'Riwayat'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomTextField(
              controller: searchController,
              hint: 'Cari riwayat scan...',
              prefixIcon: IconsaxPlusLinear.search_normal_1,
            ),
          ),
          Expanded(
            child: appleState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : appleState.errorMessage != null
                    ? Center(child: Text(appleState.errorMessage!))
                    : appleState.apples.isEmpty
                        ? const Center(
                            child: Text('Belum ada riwayat scan'),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            padding: const EdgeInsets.all(12),
                            children: appleState.apples.map((apple) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListPenyakitPage(
                                        label: apple['nama_apel'] ?? 'Unknown',
                                      ),
                                    ),
                                  );
                                },
                                child: CustomCard(
                                  label: apple['nama_apel'] ?? 'Unknown',
                                  waktuScan: _formatDate(DateTime.parse(
                                      apple['created_at'] ??
                                          DateTime.now().toIso8601String())),
                                  image: apple['image_url'] ??
                                      'assets/images/default.png',
                                ),
                              );
                            }).toList(),
                          ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inDays == 0) {
      return 'hari ini';
    } else if (difference.inDays == 1) {
      return 'kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu yang lalu';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months bulan yang lalu';
    }
  }
}
