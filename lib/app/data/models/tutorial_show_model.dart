class TutorialShowModel {
    int id;
    dynamic title;
    String type;
    String description;
    dynamic thumbnailUrl;
    dynamic videoUrl;

    TutorialShowModel({
        required this.id,
        required this.title,
        required this.type,
        required this.description,
        required this.thumbnailUrl,
        required this.videoUrl,
    });

    factory TutorialShowModel.fromJson(Map<String, dynamic> json) => TutorialShowModel(
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
