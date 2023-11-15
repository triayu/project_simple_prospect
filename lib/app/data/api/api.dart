library api;

import 'package:dio/dio.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

part 'auth_api.dart';
part 'todo_api.dart';
part 'dashboard_api/count_goal_api.dart';
part 'dashboard_api/count_up_coming_event_api.dart';
part 'event_api.dart';
part 'task_api.dart';
part 'up_daily_task_api.dart';
part 'phone_book_api.dart';
part 'message_template_api.dart';
part 'drawer_api/tutorial_api.dart';
part 'drawer_api/contact_api.dart';

mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
  GoalApi goalApi = GoalApi();
  ComingApi comingEvent = ComingApi();
  EventApi eventApi = EventApi();
  TaskApi taskApi = TaskApi();
  UpDailyTaskeApi upDailyTaskApi = UpDailyTaskeApi();
  PhoneBookApi phoneBookApi = PhoneBookApi();
  MessageTemplateApi messageTemplateApi = MessageTemplateApi();
  TutorialVideoApi tutorialApi = TutorialVideoApi();
  ContactApi contactApi = ContactApi();
}
