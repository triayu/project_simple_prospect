class BannerModel {
  String goalName;
  int? countCategory;
  int? totalContact;
  int? totalMessageTemplate;
  int? countComplitedTask;
  int? totalTask;
  int? countUpcomingEvent;
  int? totalEvent;

  BannerModel({
    required this.goalName,
    this.countCategory,
    this.totalContact,
    this.totalMessageTemplate,
    this.countComplitedTask,
    this.totalTask,
    this.countUpcomingEvent,
    this.totalEvent,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        goalName: json["goal_name"],
        countCategory: json["count_category"],
        totalContact: json["total_contact"],
        totalMessageTemplate: json["total_message_template"],
        countComplitedTask: json["count_complited_task"],
        totalTask: json["total_task"],
        countUpcomingEvent: json["count_upcoming_event"],
        totalEvent: json["total_event"],
      );

  Map<String, dynamic> toJson() => {
        "goal_name": goalName,
        "count_category": countCategory,
        "total_contact": totalContact,
        "total_message_template": totalMessageTemplate,
        "count_complited_task": countComplitedTask,
        "total_task": totalTask,
        "count_upcoming_event": countUpcomingEvent,
        "total_event": totalEvent,
      };


}
