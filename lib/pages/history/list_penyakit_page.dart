import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:apple_leaf/widgets/history/list_penyakit_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ListPenyakitPage extends StatefulWidget {
  final String? label;
  const ListPenyakitPage({super.key, required this.label});

  @override
  State<ListPenyakitPage> createState() => _ListPenyakitPageState();
}

class _ListPenyakitPageState extends State<ListPenyakitPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

          // List of Penyakit
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 12,
              itemBuilder: (context, index) {
                return ListPenyakitCard(
                  image: 'assets/images/daun_article.png',
                  title: 'Fire Blight ${index + 1}',
                  date: '10 November 2024',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
