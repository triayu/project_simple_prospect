class TaskModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? title;
  String? note;
  DateTime? dueDate;
  String? dueTime;
  String? priority;
  DateTime? reminder;
  String? status;
  int? relateTo;

  TaskModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.title,
    this.note,
    this.dueDate,
    this.dueTime,
    this.priority,
    this.reminder,
    this.status,
    this.relateTo,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        title: json["title"],
        note: json["note"],
        dueDate: json["due_date"] != null ? DateTime.parse(json["due_date"]) : null,
        dueTime: json["due_time"],
        priority: json["priority"],
        reminder: DateTime.parse(json["reminder"]),
        status: json["status"],
        relateTo: json["relate_to"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "title": title,
        "note": note,
        "due_date": dueDate != null
            ? "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}"
            : null,
        "due_time": dueTime,
        "priority": priority,
        "reminder": reminder != null ? reminder!.toIso8601String() : null,
        "status": status,
        "relate_to": relateTo,
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
