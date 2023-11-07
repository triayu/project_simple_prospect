class ComingEventModel {
  String name;
  int count;
  int total;

  ComingEventModel({
    required this.name,
    required this.count,
    required this.total,
  });

  factory ComingEventModel.fromJson(Map<String, dynamic> json) => ComingEventModel(
        name: json["name"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "total": total,
      };

  @override
  String toString() {
    return super.toString();
  }
}
