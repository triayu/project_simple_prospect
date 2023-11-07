part of api;

class ComingApi extends Fetch {
  Future<ResHandler> getComingevent() async => await get('/dashboard/up-coming-event');
}
// 