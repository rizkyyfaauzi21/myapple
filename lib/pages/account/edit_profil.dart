import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class EditProfil extends StatelessWidget {
  const EditProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Profil',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutralBlack,
          ),
        ),
        titleSpacing: 0,
        toolbarHeight: 42,
        leading: IconButton(
          icon: const Icon(
            IconsaxPlusLinear.arrow_left,
            color: neutralBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            color: neutral100,
            height: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          SizedBox(
            height: 12,
          ),
          // Foto Profil dengan ikon edit
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/1.jpg'), // Tambahkan gambar di asset
                  backgroundColor: neutral100,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: green700,
                  child: Icon(
                    IconsaxPlusLinear.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Input untuk Nama
          Text(
            'Nama',
            style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Rizky Fauzi',
              hintStyle: regularTS.copyWith(color: neutral400, fontSize: 16),
              filled: true,
              fillColor: neutral50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Input untuk Email
          Text(
            'Email',
            style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'rizkyfauzi01@gmail.com',
              hintStyle: regularTS.copyWith(color: neutral400, fontSize: 16),
              filled: true,
              fillColor: neutral50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
                borderSide: BorderSide(color: neutral100),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Tombol Simpan
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika simpan
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: green700,
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Text(
              'Simpan',
              style: mediumTS.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
