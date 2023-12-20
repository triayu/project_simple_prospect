class Data {
  int totalEvent;
  List<UpcomingEventModel> upcomingEventModels;

  Data({
    required this.totalEvent,
    required this.upcomingEventModels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalEvent: json["totalEvent"],
        upcomingEventModels: List<UpcomingEventModel>.from(
          json["UpcomingEventModels"].map((x) => UpcomingEventModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "totalEvent": totalEvent,
        "UpcomingEventModels": List<dynamic>.from(upcomingEventModels.map((x) => x.toJson())),
      };
}

class UpcomingEventModel {
  String name;
  DateTime date;

  UpcomingEventModel({
    required this.name,
    required this.date,
  });

  factory UpcomingEventModel.fromJson(Map<String, dynamic> json) => UpcomingEventModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "dateTime":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}",
      };
}


// class ComingEventModel {
//   String? name;
//   DateTime? date;

//   ComingEventModel({
//     this.name,
//     this.date,
//   });

//   factory ComingEventModel.fromJson(Map<String, dynamic> json) => ComingEventModel(
//         name: json["name"],
//         date: DateTime.parse(json["date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "date": date != null
//             ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
//             : null,
//       };
// }
