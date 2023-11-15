class ContactModel {
  int? id;
  int? userId;
  UserFirstName? userFirstName;
  UserLastName? userLastName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? homeNumber;
  String? workNumber;
  String? email;

  ContactModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.homeNumber,
    this.workNumber,
    this.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: userFirstNameValues.map[json["user_first_name"]]!,
        userLastName: userLastNameValues.map[json["user_last_name"]]!,
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        homeNumber: json["homeNumber"],
        workNumber: json["workNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstNameValues.reverse[userFirstName],
        "user_last_name": userLastNameValues.reverse[userLastName],
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "homeNumber": homeNumber,
        "workNumber": workNumber,
        "email": email,
      };
}

enum UserFirstName { ADINDA }

final userFirstNameValues = EnumValues({"adinda": UserFirstName.ADINDA});

enum UserLastName { ISTIKA }

final userLastNameValues = EnumValues({"istika": UserLastName.ISTIKA});

class Links {
  String first;
  String last;
  dynamic prev;
  String next;

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
