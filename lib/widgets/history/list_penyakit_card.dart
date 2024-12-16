import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/pages/history/detail_penyakit_page.dart';
import 'package:apple_leaf/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListPenyakitCard extends StatelessWidget {
  final String image, title, date, description, symptom, solution;
  final int historyId;
  final String appleId;
  const ListPenyakitCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.description,
    required this.symptom,
    required this.solution,
    required this.historyId,
    required this.appleId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPenyakitPage(
              title: title,
              image: image,
              description: description,
              symptoms: symptom,
              treatment: solution,
              historyId: historyId,
              appleId: appleId,
            ),
          ),
        );
      },
      child: Container(
        height: 100 + 16,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: neutral100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: ApiConfig.scanImagesPath + image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/daun_article.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: mediumTS.copyWith(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style: regularTS.copyWith(color: neutral400),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
