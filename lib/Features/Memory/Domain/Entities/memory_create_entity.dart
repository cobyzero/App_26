class MemoryCreateEntity {
  final String date;
  final List<String> image;
  final List<String> pathImage;
  final bool isBlocked;
  final String message;
  final String userId;
  final String nameUser;

  MemoryCreateEntity({
    required this.date,
    required this.image,
    required this.isBlocked,
    required this.message,
    required this.userId,
    required this.pathImage,
    required this.nameUser,
  });

  MemoryCreateEntity copyWith({
    String? date,
    List<String>? image,
    bool? isBlocked,
    String? message,
    String? userId,
    List<String>? pathImage,
    String? nameUser,
  }) =>
      MemoryCreateEntity(
        date: date ?? this.date,
        image: image ?? this.image,
        isBlocked: isBlocked ?? this.isBlocked,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        pathImage: pathImage ?? this.pathImage,
        nameUser: nameUser ?? this.nameUser,
      );

  factory MemoryCreateEntity.fromJson(Map<String, dynamic> json) => MemoryCreateEntity(
        date: json["date"],
        image: List<String>.from(json["image"].map((x) => x)),
        isBlocked: json["isBlocked"],
        message: json["message"],
        userId: json["userId"],
        nameUser: json["nameUser"],
        pathImage: [],
      );

  Map<String, dynamic> toJson({String id = ""}) => {
        "date": date,
        "image": image,
        "isBlocked": isBlocked,
        "message": message,
        "userId": userId,
        "id": id,
        "nameUser": nameUser,
      };
}
