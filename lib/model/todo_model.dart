class TodoModel {
  DateTime? createdAt;
  String? title;
  String? description;
  bool? isDone;
  String? id;

  TodoModel({
    this.createdAt,
    this.title,
    this.description,
    this.isDone,
    this.id,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        createdAt: json["createdAt"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["createdAt"] * 1000),
        title: json["title"],
        description: json["description"],
        isDone: json["is_done"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.millisecondsSinceEpoch,
        "title": title,
        "description": description,
        "is_done": isDone,
        "id": id,
      };
}
