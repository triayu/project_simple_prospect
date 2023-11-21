class ComingEventModel {
  String? name;
  DateTime? date;

  ComingEventModel({
    this.name,
    this.date,
  });

  factory ComingEventModel.fromJson(Map<String, dynamic> json) => ComingEventModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
      };
}
