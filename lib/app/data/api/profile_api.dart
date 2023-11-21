part of api;

class ProfileApi extends Fetch {
  Future<ResHandler> getProfile() async => await get('/user');
}
