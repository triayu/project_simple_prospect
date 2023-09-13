library api;

import 'package:simple_prospect/app/utils/fetch/fetch.dart';

part 'auth_api.dart';
part 'todo_api.dart';

mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
}
