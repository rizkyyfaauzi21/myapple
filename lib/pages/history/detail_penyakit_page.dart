import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/provider/auth_provider.dart';
import 'package:apple_leaf/provider/history_service.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/history/detail_penyakit_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPenyakitPage extends ConsumerWidget {
  final String title;
  final String image;
  final String description;
  final String treatment;
  final String symptoms;
  final int historyId;
  final String appleId;

  const DetailPenyakitPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.treatment,
    required this.symptoms,
    required this.historyId,
    required this.appleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: customAppBar(
          context,
          actions: [
            IconButton(
              onPressed: () => handleDeleteHistory(context, ref),
              icon: const Icon(IconsaxPlusLinear.trash),
              color: redBase,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Image of Penyakit
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxHeight: 230),
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiConfig.scanImagesPath + image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(green700)),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/apple_card.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title of Penyakit
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      border: Border.all(color: neutral100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          title.toLowerCase() == 'healthy'
                              ? 'Apel anda sehat'
                              : 'Terjangkit $title',
                          style: mediumTS.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lihat diagnosis untuk detail lebih lanjut',
                          style: regularTS.copyWith(color: neutral400),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tab Bar
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: green700,
                      overlayColor: const MaterialStatePropertyAll(green50),
                      labelStyle:
                          mediumTS.copyWith(fontSize: 16, color: green700),
                      unselectedLabelStyle:
                          mediumTS.copyWith(fontSize: 16, color: neutral400),
                      tabs: const [
                        Tab(child: Text('Definisi')),
                        Tab(child: Text('Gejala')),
                        Tab(child: Text('Penanganan')),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  DetailPenyakitTab(
                    text: description,
                  ),
                  DetailPenyakitTab(
                    text: symptoms,
                  ),
                  DetailPenyakitTab(
                    text: treatment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleDeleteHistory(BuildContext context, WidgetRef ref) async {
    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => CustomDialog(
          title: 'Hapus riwayat ini?',
          subtitle: 'Semua informasi yang terkait dengan diagnosis ini akan hilang.',
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isDialogButton: true,
                    text: 'Hapus',
                    backgroundColor: redBase,
                    onTap: () => Navigator.of(context).pop(true),
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
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      // If user confirmed deletion
      if (result == true) {
        final historyService = ref.read(historyServiceProvider);
        final userId = ref.read(authProvider).userData?['id'].toString();

        // Show loading indicator
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(green700)),
            ),
          );
        }

        // Delete history
        await historyService.deleteHistory(historyId.toString());

        // Refresh histories list using the correct provider
        
          // Refresh the apple histories state
          ref.refresh(appleHistoryProvider(appleId.toString()));
          // Also refresh the main apple list if needed
          if (userId != null) {
            ref.read(appleProvider(userId).notifier).fetchApples();
          }

        if (context.mounted) {
          // Hide loading indicator
          Navigator.pop(context);
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Riwayat berhasil dihapus'),
              backgroundColor: green700,
            ),
          );

          // Go back to previous screen
          Navigator.pop(context);
        }
      }
    } catch (e) {
      // Hide loading if shown
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus riwayat: $e'),
            backgroundColor: redBase,
          ),
        );
      }
    }
  }
}
