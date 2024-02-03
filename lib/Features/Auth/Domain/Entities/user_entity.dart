class UserEntity {
  final String name;
  final String key;
  final int keys;
  final String id;
  final int rol;
  UserEntity({
    required this.rol,
    required this.name,
    required this.key,
    required this.keys,
    required this.id,
  });

  UserEntity copyWith({
    String? name,
    String? key,
    int? keys,
    String? id,
    int? rol,
  }) =>
      UserEntity(
        name: name ?? this.name,
        key: key ?? this.key,
        keys: keys ?? this.keys,
        id: id ?? this.id,
        rol: rol ?? this.rol,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        name: json["name"],
        key: json["key"],
        keys: json["keys"],
        id: json["id"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "keys": keys,
        "id": id,
        "rol": rol,
      };
}
