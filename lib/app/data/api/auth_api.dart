part of api;

class AuthApi extends Fetch {
  Future<ResHandler> login(Map<String, dynamic> data) async => await post('/login', FormData.fromMap(data));

  Future<ResHandler> register(Map<String, dynamic> data) async => await post('/register', FormData.fromMap(data));

  Future<ResHandler> event(Map<String, dynamic> data) async => await post('/event', FormData.fromMap(data));

  Future<ResHandler> task(Map<String, dynamic> data) async => await post('/task', FormData.fromMap(data));
}
