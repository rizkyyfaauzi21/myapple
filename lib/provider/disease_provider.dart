class DiseaseInfo {
  final String name;
  final String symptoms;
  final String treatment;
  final String description;

  DiseaseInfo({
    required this.name,
    required this.symptoms,
    required this.treatment,
    required this.description,
  });
}

final Map<int, DiseaseInfo> diseaseDetails = {
  1: DiseaseInfo(
    name: 'Scab',
    symptoms: 'Bercak-bercak gelap dan kasar pada daun dan buah.',
    treatment:
        'Buang daun dan buah yang terkena, aplikasikan fungisida, dan pangkas pohon untuk sirkulasi udara yang lebih baik.',
    description:
        'Scab adalah penyakit jamur yang menyebabkan bercak-bercak gelap dan kasar pada daun dan buah.',
  ),
  2: DiseaseInfo(
    name: 'Rust',
    symptoms: 'Bercak-bercak oranye pada daun dan dapat mengurangi hasil buah.',
    treatment:
        'Buang daun yang terinfeksi, aplikasikan fungisida berbasis sulfur, dan pastikan pohon memiliki sirkulasi udara yang baik.',
    description:
        'Rust adalah infeksi jamur yang menyebabkan bercak-bercak oranye pada daun dan dapat mengurangi hasil buah.',
  ),
  3: DiseaseInfo(
    name: 'Healthy',
    symptoms: 'Tidak ada tanda-tanda penyakit',
    treatment: 'Tidak ada tindakan yang perlu dilakukan.',
    description:
        'Tanaman tidak menunjukkan tanda-tanda penyakit dan berada dalam kondisi optimal.',
  ),
};
