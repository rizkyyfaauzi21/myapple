import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DetailpenyakitPage extends StatelessWidget {
  final String title;
  const DetailpenyakitPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                IconsaxPlusLinear.trash,
                color: Color(0xFFFF3B30),
              ),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(color: neutralWhite),
          child: ListView(
            children: [
              Divider(
                height: 1,
                color: neutral100,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxHeight: 230),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/images/apple_card.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: neutral50,
                            border: Border.all(color: neutral100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Terjangkit $title',
                                style: mediumTS.copyWith(fontSize: 18),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Lihat diagnosis untuk detail gejala dan penanganan',
                                style: regularTS.copyWith(color: neutral400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
