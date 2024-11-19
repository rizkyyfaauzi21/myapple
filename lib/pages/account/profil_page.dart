import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutralBlack,
          ),
        ),
        toolbarHeight: 52,
      ),
      body: ListView(
        children: [
          const Divider(
            height: 1,
            color: neutral100,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: neutral100,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rizky Fauzi',
                      style: mediumTS.copyWith(
                        fontSize: 16,
                        color: neutralBlack,
                      ),
                    ),
                    Text(
                      'rizkyfauzi01@gmail.com',
                      style: regularTS.copyWith(
                        color: neutral400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: neutral100,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/icons/user-edit.png',
                          ),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Edit Profil',
                          style: mediumTS.copyWith(
                            fontSize: 16,
                            color: neutralBlack,
                          ),
                        ),
                        const Spacer(),
                        const ImageIcon(
                          AssetImage('assets/icons/arrow-right.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: neutral100,
                ),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/icons/key.png',
                          ),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Ubah Profil',
                          style: mediumTS.copyWith(
                            fontSize: 16,
                            color: neutralBlack,
                          ),
                        ),
                        const Spacer(),
                        const ImageIcon(
                          AssetImage('assets/icons/arrow-right.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: neutral100,
                ),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/icons/logout.png',
                          ),
                          size: 24,
                          color: Color(0xFFFF3B30),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Keluar',
                          style: mediumTS.copyWith(
                            fontSize: 16,
                            color: const Color(0xFFFF3B30),
                          ),
                        ),
                        const Spacer(),
                        const ImageIcon(
                          AssetImage('assets/icons/arrow-right.png'),
                          color: Color(0xFFFF3B30),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
