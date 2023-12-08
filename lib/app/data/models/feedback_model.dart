class FeedbackModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? title;
  String? feedbackMessage;
  int? rating;

  FeedbackModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.title,
    this.feedbackMessage,
    this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        title: json["title"],
        feedbackMessage: json["feedback_message"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "title": title,
        "feedback_message": feedbackMessage,
        "rating": rating,
      };
}
