class EventModel {
  final int id;
  final int userId;
  final String userFirstName;
  final String userLastName;
  final String title;
  final String meetingWith;
  final String meetingType;
  final DateTime startDate;
  final DateTime endDate;
  final String latitude;
  final String longitude;
  final String location;
  final DateTime reminder;
  final String note;
  final dynamic phoneBookId;

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
    required this.phoneBookId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
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
      phoneBookId: json["phone_book_id"],
    );
  }
}
