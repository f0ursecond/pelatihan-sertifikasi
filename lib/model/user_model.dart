class UserModel {
  DateTime? createdAt;
  String? name;
  String? avatar;
  String? address;
  String? id;

  UserModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.address,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        address: json["address"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "address": address,
        "id": id,
      };
}
