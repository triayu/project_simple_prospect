class ComingEventModel {
    String name;
    DateTime date;
    int count;
    int total;

    ComingEventModel({
        required this.name,
        required this.date,
        required this.count,
        required this.total,
    });

    factory ComingEventModel.fromJson(Map<String, dynamic> json) => ComingEventModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        count: json["count"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": date.toIso8601String(),
        "count": count,
        "total": total,
    };
}