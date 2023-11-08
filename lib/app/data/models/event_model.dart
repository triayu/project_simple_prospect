class EventModel {
  int id;
  int userId;
  String userFirstName;
  String userLastName;
  String title;
  String meetingWith;
  String meetingType;
  DateTime startDate;
  DateTime endDate;
  String latitude;
  String longitude;
  String location;
  DateTime reminder;
  String note;

  EventModel({
    required this.id,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.title,
    required this.meetingWith,
    required this.meetingType,
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.reminder,
    required this.note,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        title: json["title"],
        meetingWith: json["meeting_with"],
        meetingType: json["meeting_type"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: json["location"],
        reminder: DateTime.parse(json["reminder"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "title": title,
        "meeting_with": meetingWith,
        "meeting_type": meetingType,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "reminder": reminder.toIso8601String(),
        "note": note,
      };
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
