part of model;

class TutorialModel {
  int? id;
  String? type;
  String? description;
  dynamic thumbnailUrl;
  dynamic videoUrl;

  TutorialModel({
    this.id,
    this.type,
    this.description,
    this.thumbnailUrl,
    this.videoUrl,
  });

  factory TutorialModel.fromJson(Map<String, dynamic> json) => TutorialModel(
        id: json["id"],
        type: json["type"],
        description: json["description"],
        thumbnailUrl: json["thumbnail_url"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "description": description,
        "thumbnail_url": thumbnailUrl,
        "video_url": videoUrl,
      };
}
