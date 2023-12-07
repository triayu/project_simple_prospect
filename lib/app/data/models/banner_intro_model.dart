class BannerModel {
  String name;
  int count;
  int total;

  BannerModel({
    required this.name,
    required this.count,
    required this.total,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
