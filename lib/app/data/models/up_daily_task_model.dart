class UpDailyTaskModel {
  DateTime? reminder;
  String? fullName;
  String? title;

  UpDailyTaskModel({
    this.reminder,
    this.fullName,
    this.title,
  });

  factory UpDailyTaskModel.fromJson(Map<String, dynamic> json) => UpDailyTaskModel(
        reminder: DateTime.parse(json["reminder"]),
        fullName: json["full_name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "reminder": reminder != null
            ? "${reminder!.year.toString().padLeft(4, '0')}-${reminder!.month.toString().padLeft(2, '0')}-${reminder!.day.toString().padLeft(2, '0')}"
            : null,
        "full_name": fullName,
        "title": title,
      };
}
