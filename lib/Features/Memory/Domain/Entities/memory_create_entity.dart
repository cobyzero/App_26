class MemoryCreateEntity {
  final String date;
  final String image;
  final bool isBlocked;
  final String message;
  final String userId;

  MemoryCreateEntity({
    required this.date,
    required this.image,
    required this.isBlocked,
    required this.message,
    required this.userId,
  });

  MemoryCreateEntity copyWith({
    String? date,
    String? image,
    bool? isBlocked,
    String? message,
    String? userId,
  }) =>
      MemoryCreateEntity(
        date: date ?? this.date,
        image: image ?? this.image,
        isBlocked: isBlocked ?? this.isBlocked,
        message: message ?? this.message,
        userId: userId ?? this.userId,
      );

  factory MemoryCreateEntity.fromJson(Map<String, dynamic> json) => MemoryCreateEntity(
        date: json["date"],
        image: json["image"],
        isBlocked: json["isBlocked"],
        message: json["message"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "image": image,
        "isBlocked": isBlocked,
        "message": message,
        "userId": userId,
      };
}
