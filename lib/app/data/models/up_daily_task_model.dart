class UpDailyTaskModel {
  String? name;
  int? count;
  int? total;
  DateTime? dueDate;
  String? dueTime;

  UpDailyTaskModel({
    this.name,
    this.count,
    this.total,
    this.dueDate,
    this.dueTime,
  });

  factory UpDailyTaskModel.fromJson(Map<String, dynamic> json) => UpDailyTaskModel(
        name: json["name"],
        count: json["count"],
        total: json["total"],
        dueDate: DateTime.parse(json["due_date"]),
        dueTime: json["due_time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "total": total,
        "due_date": dueDate != null
            ? "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}"
            : null,
        "due_time": dueTime,
      };
}
