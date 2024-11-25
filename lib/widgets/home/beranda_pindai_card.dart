import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/configs/theme.dart';

class BerandaPindaiCard extends StatelessWidget {
  final VoidCallback? onScan;
  const BerandaPindaiCard({
    super.key,
    this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/apple_background.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(153, 0, 0, 0),
                Colors.transparent,
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pindai Kesehatan\nPohon Apelmu!',
                    style: mediumTS.copyWith(
                      fontSize: 20,
                      color: neutralWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: onScan,
                    child: Ink(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(context).size.width / 2.45,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(64),
                          color: const Color(0xffD3F3FA),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconsaxPlusLinear.scan,
                              color: neutralBlack,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Pindai',
                              style: mediumTS.copyWith(
                                fontSize: 16,
                                color: neutralBlack,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
