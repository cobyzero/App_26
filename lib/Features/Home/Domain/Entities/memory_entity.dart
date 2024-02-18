class MemoryEntity {
  final String message;
  final List<String> image;
  final String userId;
  final bool isBlocked;
  final DateTime date;
  final String id;
  final String nameUser;

  MemoryEntity({
    required this.message,
    required this.image,
    required this.userId,
    required this.isBlocked,
    required this.date,
    required this.id,
    required this.nameUser,
  });

  MemoryEntity copyWith({
    String? message,
    List<String>? image,
    String? userId,
    bool? isBlocked,
    DateTime? date,
    String? id,
    String? nameUser,
  }) =>
      MemoryEntity(
        message: message ?? this.message,
        image: image ?? this.image,
        userId: userId ?? this.userId,
        isBlocked: isBlocked ?? this.isBlocked,
        date: date ?? this.date,
        id: id ?? this.id,
        nameUser: nameUser ?? this.nameUser,
      );

  factory MemoryEntity.fromJson(Map<String, dynamic> json) => MemoryEntity(
        message: json["message"],
        image: List<String>.from(json["image"].map((x) => x)),
        userId: json["userId"],
        isBlocked: json["isBlocked"],
        date: DateTime.parse(json["date"]),
        id: json["id"],
        nameUser: json["nameUser"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "image": image,
        "userId": userId,
        "isBlocked": isBlocked,
        "date": date,
        "id": id,
        "nameUser": nameUser,
      };
}
