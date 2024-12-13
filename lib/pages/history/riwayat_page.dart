import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/provider/auth_provider.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RiwayatPage extends ConsumerStatefulWidget {
  const RiwayatPage({super.key});

  @override
  ConsumerState<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends ConsumerState<RiwayatPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch apples when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = ref.read(authProvider).userData?['id'].toString();
      if (userId != null) {
        ref.read(appleProvider(userId).notifier).fetchApples();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProvider).userData?['id'].toString();
    final appleState = ref.watch(appleProvider(userId ?? ''));

    return Scaffold(
      appBar: mainAppBar(context, title: 'Riwayat'),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomTextField(
              prefixIcon: IconsaxPlusLinear.search_normal_1,
              hint: 'Cari riwayat',
              controller: searchController,
            ),
          ),

          Expanded(
            child: appleState.apples.isEmpty
                ? const Center(
                    child: Text('Belum ada riwayat'),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    padding: const EdgeInsets.all(12),
                    children: appleState.apples.map((apple) {
                      return CustomCard(
                        appleId: apple['id'].toString(),
                        label: apple['nama_apel'] ?? 'Unknown Apple',
                        waktuScan: 'Terakhir scan 1 minggu yang lalu',
                        image: apple['image_url'] ?? 'assets/images/apple_card.png',
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
