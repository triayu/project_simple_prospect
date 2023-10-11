part of api;

class AuthApi extends Fetch {
  Future<ResHandler> login(Map<String, dynamic> data) async => await post('/login', FormData.fromMap(data));

  register(Map<String, dynamic> map) {}
}
