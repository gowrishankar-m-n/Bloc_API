class PostDataUiModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostDataUiModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDataUiModel.fromMap(Map<String, dynamic> json) => PostDataUiModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
