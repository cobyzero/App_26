class MemoryEntity {
  final String message;
  final String image;
  final String userId;
  final bool isBlocked;
  final DateTime date;
  final String id;

  MemoryEntity({
    required this.message,
    required this.image,
    required this.userId,
    required this.isBlocked,
    required this.date,
    required this.id,
  });

  MemoryEntity copyWith({
    String? message,
    String? image,
    String? userId,
    bool? isBlocked,
    DateTime? date,
    String? id,
  }) =>
      MemoryEntity(
        message: message ?? this.message,
        image: image ?? this.image,
        userId: userId ?? this.userId,
        isBlocked: isBlocked ?? this.isBlocked,
        date: date ?? this.date,
        id: id ?? this.id,
      );

  factory MemoryEntity.fromJson(Map<String, dynamic> json) => MemoryEntity(
        message: json["message"],
        image: json["image"],
        userId: json["userId"],
        isBlocked: json["isBlocked"],
        date: DateTime.parse(json["date"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "image": image,
        "userId": userId,
        "isBlocked": isBlocked,
        "date": date,
        "id": id,
      };
}
