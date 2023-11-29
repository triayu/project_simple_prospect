class EventModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? title;
  String? meetingWith;
  String? meetingType;
  DateTime? startDate;
  DateTime? endDate;
  String? latitude;
  String? longitude;
  String? location;
  String? reminder;
  String? note;

  EventModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.title,
    this.meetingWith,
    this.meetingType,
    this.startDate,
    this.endDate,
    this.latitude,
    this.longitude,
    this.location,
    this.reminder,
    this.note,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        title: json["title"],
        meetingWith: json["meeting_with"],
        meetingType: json["meeting_type"],
        startDate: json["start_date"] != null ? DateTime.parse(json["start_date"]) : null,
        endDate: json["end_date"] != null ? DateTime.parse(json["end_date"]) : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: json["location"],
        reminder: json["reminder"],
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
        // buat yg bwahnya samaain
        "start_date": startDate != null ? startDate!.toIso8601String() : null,
        "end_date": endDate != null ? endDate!.toIso8601String() : null,
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "reminder": reminder,
        "note": note,
      };
}
