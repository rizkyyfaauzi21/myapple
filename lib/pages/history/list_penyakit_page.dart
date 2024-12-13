import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:apple_leaf/widgets/history/list_penyakit_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/history_provider.dart';

class ListPenyakitPage extends ConsumerStatefulWidget {
  final String? label;
  const ListPenyakitPage({super.key, required this.label});

  @override
  ConsumerState<ListPenyakitPage> createState() => _ListPenyakitPageState();
}

class _ListPenyakitPageState extends ConsumerState<ListPenyakitPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyProvider);

    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: customAppBar(context, title: widget.label.toString()),
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

          // Handling loading and error
          Expanded(
            child: historyState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : historyState.errorMessage != null
                    ? Center(child: Text(historyState.errorMessage!))
                    : historyState.histories.isEmpty
                        ? const Center(child: Text('Tidak ada riwayat'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: historyState.histories.length,
                            itemBuilder: (context, index) {
                              final history = historyState.histories[index];
                              print(
                                  'History data: ${history.toJson()}'); // Debugging
                              return ListPenyakitCard(
                                image: history.scanImagePath,
                                title: diseaseNames[history.diseaseInfoId] ??
                                    'Unknown Disease',
                                date: history.scanDate.toString().split(' ')[0],
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
