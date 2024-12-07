class Article {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String source;
  final DateTime publicationDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.source,
    required this.publicationDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imagePath: json['image_path'],
      source: json['source'],
      publicationDate: DateTime.parse(json['publication_date']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_path': imagePath,
      'source': source,
      'publication_date': publicationDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
