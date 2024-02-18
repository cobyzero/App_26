class UserEntity {
  final String name;
  final int keys;
  final String id;
  final String key;

  UserEntity({
    required this.name,
    required this.keys,
    required this.id,
    required this.key,
  });

  UserEntity copyWith({
    String? name,
    int? keys,
    String? id,
    String? key,
  }) =>
      UserEntity(
        name: name ?? this.name,
        keys: keys ?? this.keys,
        id: id ?? this.id,
        key: key ?? this.key,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        name: json["name"],
        keys: json["keys"],
        id: json["id"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "keys": keys,
        "id": id,
        "key": key,
      };
}
