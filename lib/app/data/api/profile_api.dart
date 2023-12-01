part of api;

class ProfileApi extends Fetch {
  Future<ResHandler> getProfile() async => await get('/user');
 Future<ResHandler> updateProfile(Map<String, dynamic> map, int id) async =>
      await put('/user/$id', FormData.fromMap(map));
  Future<ResHandler> postProfile(Map<String, dynamic> data) async => await post('/user', FormData.fromMap(data));
}
