library api;

import 'package:dio/dio.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

part 'auth_api.dart';
part 'todo_api.dart';
part 'count_goal_api.dart';

mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
  GoalApi goalApi = GoalApi();
  
}
