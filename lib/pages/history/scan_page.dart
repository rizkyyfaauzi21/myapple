import 'dart:io';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/provider/auth_provider.dart';
import 'package:apple_leaf/widgets/apple/apple_card.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apple_leaf/widgets/history/detail_penyakit_tab.dart';
import 'package:image_picker/image_picker.dart';

final isSavingProvider = StateProvider<bool>((ref) => false);

class ScanPage extends ConsumerWidget {
  final String title;
  final XFile image;
  final String predictedLabel;
  final int userId;
  final Map<String, dynamic> category;
  const ScanPage({
    super.key,
    required this.image,
    required this.title,
    required this.predictedLabel,
    required this.category,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final koleksiController = TextEditingController();

    final appleNotifier = ref.read(appleProvider(userId.toString()).notifier);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: customAppBar(
          context,
          actions: [
            TextButton(
              onPressed: () async {
                // Panggil handleSimpanPenyakit terlebih dahulu
                await handleSimpanPenyakit(context, koleksiController, ref);
                // Setelah selesai, baru fetch data terbaru
                if (context.mounted) {
                  appleNotifier.fetchApples();
                }
              },
              child: Text(
                'Simpan',
                style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Image of Penyakit
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 230),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(File(image.path)),
                        fit: BoxFit.cover,
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
                      color: neutral50,
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
                          'Lihat diagnosis untuk detail gejala dan penanganan',
                          style: regularTS.copyWith(color: neutral400),
                          textAlign: TextAlign.center,
                        ),
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
                        Tab(child: Text('Solusi')),
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
                    text: category['description'] ?? 'Deskripsi tidak tersedia',
                  ),
                  DetailPenyakitTab(
                    text: category['symptoms'] ?? 'Gejala tidak tersedia',
                  ),
                  DetailPenyakitTab(
                    text: category['treatment'] ?? 'Penanganan tidak tersedia',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleSimpanPenyakit(
    BuildContext context,
    TextEditingController koleksiController,
    WidgetRef ref,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: neutralWhite,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final appleState = ref.watch(appleProvider(userId.toString()));
            
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem Ipsum',
                    style: mediumTS.copyWith(fontSize: 18, color: neutralBlack),
                  ),
                  Text(
                    'lorem Ipsum Dolor Sit Amet',
                    style: regularTS.copyWith(fontSize: 14, color: neutral400),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Koleksimu',
                        style: mediumTS.copyWith(fontSize: 18, color: neutralBlack),
                      ),
                      GestureDetector(
                        onTap: () =>
                            handleKoleksiBaru(context, koleksiController, ref),
                        child: Text(
                          'Koleksi Baru',
                          style: mediumTS.copyWith(fontSize: 12, color: green700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: appleState.apples.length,
                      itemBuilder: (context, index) {
                        final apple = appleState.apples[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppleCard(
                            imagePath: apple['image_url'] ??
                                'assets/images/default_image.png',
                            scanImagePath: image,
                            appleName: apple['nama_apel'] ?? 'Unknown Apple',
                            lastScan: 'Terakhir discan 1 hari yang lalu',
                            appleId: apple['id'].toString(),
                            userId: userId.toString(),
                            diseaseInfoId: category['id'].toString(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> handleKoleksiBaru(
    BuildContext context,
    TextEditingController koleksiController,
    WidgetRef ref,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        // Reset controller when dialog opens
        koleksiController.clear();
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomForm(
                title: 'Nama Koleksi',
                controller: koleksiController,
                keyboardType: TextInputType.name,
                hint: 'Masukkan Nama Koleksi',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isDialogButton: true,
                      text: 'Batal',
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey,
                      textColor: Colors.black,
                      onTap: () {
                        koleksiController.clear(); // Clear when canceling
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final isLoading = ref.watch(isSavingProvider);

                        return CustomButton(
                          isDialogButton: true,
                          text: isLoading ? 'Menyimpan...' : 'Simpan',
                          backgroundColor: isLoading ? Colors.grey : green700,
                          onTap: isLoading
                              ? null
                              : () async {
                                  final appleService =
                                      ref.read(appleServiceProvider);
                                  final notifier =
                                      ref.read(isSavingProvider.notifier);
                                  final appleNotifier =
                                      ref.read(appleProvider(userId.toString())
                                          .notifier);

                                  try {
                                    notifier.state = true; // Set loading

                                    // Menunggu proses addApple selesai
                                    await appleService.addApple(
                                      name: koleksiController.text.trim(),
                                      context: context,
                                      imagePath: image,
                                      userId: userId.toString(),
                                    );

                                    // Refresh apple list
                                    await appleNotifier.fetchApples();

                                    // Clear controller after successful save
                                    koleksiController.clear();
                                    
                                    Navigator.of(context).pop();

                                    // Menampilkan SnackBar hanya setelah addApple berhasil
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Koleksi berhasil disimpan!'),
                                          backgroundColor: green700,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    // Menangani error dengan SnackBar jika terjadi kesalahan
                                    print('Error: $e');

                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Gagal menyimpan apel: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } finally {
                                    notifier.state = false; // Reset loading
                                  }
                                },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> handleDeleteRiwayat(BuildContext context) {
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
                  onTap: () {},
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
