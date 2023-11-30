class MessageTemplateModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? title;
  String? message;
  dynamic attachment;

  MessageTemplateModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.title,
    this.message,
    this.attachment,
  });

  factory MessageTemplateModel.fromJson(Map<String, dynamic> json) => MessageTemplateModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        title: json["title"],
        message: json["message"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "title": title,
        "message": message,
        "attachment": attachment,
      };
}
