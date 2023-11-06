class BannerIntroModel {
  String name;
  int count;
  int total;

  BannerIntroModel({
    required this.name,
    required this.count,
    required this.total,
  });

  factory BannerIntroModel.fromJson(Map<String, dynamic> json) => BannerIntroModel(
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
