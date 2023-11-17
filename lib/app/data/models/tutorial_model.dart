part of model;

class TutorialModel {
  int? id;
  dynamic title;
  String? type;
  String? description;
  dynamic thumbnailUrl;
  dynamic videoUrl;

  TutorialModel({
    this.id,
    this.title,
    this.type,
    this.description,
    this.thumbnailUrl,
    this.videoUrl,
  });

  factory TutorialModel.fromJson(Map<String, dynamic> json) => TutorialModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        description: json["description"],
        thumbnailUrl: json["thumbnail_url"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "description": description,
        "thumbnail_url": thumbnailUrl,
        "video_url": videoUrl,
      };
}
