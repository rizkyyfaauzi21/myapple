class Apple {
  final int id;
  final String name;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Apple({
    required this.id,
    required this.name,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Apple.fromJson(Map<String, dynamic> json) {
    return Apple(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
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
      'name': name,
      'user_id': userId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
