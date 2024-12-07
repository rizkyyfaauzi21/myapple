class AppleHistory {
  final int id;
  final int appleId;
  final int historyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppleHistory({
    required this.id,
    required this.appleId,
    required this.historyId,
    this.createdAt,
    this.updatedAt,
  });

  factory AppleHistory.fromJson(Map<String, dynamic> json) {
    return AppleHistory(
      id: json['id'],
      appleId: json['apple_id'],
      historyId: json['history_id'],
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
      'apple_id': appleId,
      'history_id': historyId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
