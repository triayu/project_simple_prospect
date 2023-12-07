part of api;

class ComingApi extends Fetch {
  Future<ResHandler> getUpComingEvent() async => await get('/dashboard/up-coming-event');
}
