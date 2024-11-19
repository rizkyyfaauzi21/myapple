import 'package:apple_leaf/pages/history/listPenyakit_page.dart';
import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final String waktuScan;
  final String image;

  const CustomCard({
    super.key,
    required this.label,
    required this.waktuScan,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // return GridView.count(
    //   crossAxisCount: 2,
    //   primary: false,
    //   padding: const EdgeInsets.all(20),
    //   crossAxisSpacing: 10,
    //   mainAxisSpacing: 10,
    //   children: <Widget>[
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListpenyakitPage(
              label: label,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: neutral100),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image.toString(),
              height: 128,
              width: MediaQuery.of(context).size.width / 2 - 20,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: mediumTS.copyWith(
                      color: neutralBlack,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 46,
                    child: Text(
                      waktuScan,
                      style: regularTS.copyWith(
                        fontSize: 12,
                        color: neutral400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
