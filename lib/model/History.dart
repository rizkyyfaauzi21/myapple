class History {
  final int id;
  final DateTime scanDate;
  final int userId;
  final String scanImagePath;
  final int diseaseInfoId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  History({
    required this.id,
    required this.scanDate,
    required this.userId,
    required this.scanImagePath,
    required this.diseaseInfoId,
    this.createdAt,
    this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      scanDate: DateTime.parse(json['scan_date']),
      userId: json['user_id'],
      scanImagePath: json['scan_image_path'],
      diseaseInfoId: json['disease_info_id'],
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
      'scan_date': scanDate.toIso8601String(),
      'user_id': userId,
      'scan_image_path': scanImagePath,
      'disease_info_id': diseaseInfoId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
