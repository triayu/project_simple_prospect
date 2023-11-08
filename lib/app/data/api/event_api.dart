part of api;

class EventApi extends Fetch {
  Future<ResHandler> getEvent() async => await get('/event');
}
