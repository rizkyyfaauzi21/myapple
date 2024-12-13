class HistoryResponse {
  final bool success;
  final String message;
  final HistoryData data;

  HistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      success: json['success'],
      message: json['message'],
      data: HistoryData.fromJson(json['data']),
    );
  }
}

class HistoryData {
  final int currentPage;
  final List<History> histories;
  final int totalPages;

  HistoryData({
    required this.currentPage,
    required this.histories,
    required this.totalPages,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    var historiesList = json['data'] as List;
    List<History> histories =
        historiesList.map((history) => History.fromJson(history)).toList();

    return HistoryData(
      currentPage: json['current_page'],
      histories: histories,
      totalPages: json['last_page'],
    );
  }
}

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
}
