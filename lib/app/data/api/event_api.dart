part of api;

class EventApi extends Fetch {
  Future<ResHandler> getEvent() async => await get('/event');
  Future<ResHandler> deleteEvent(int id) async => await delete('/event/$id');
  Future<ResHandler> addEvent(Map<String, dynamic> map) async {
    return await post('/event', FormData.fromMap(map));
  }

  Future<ResHandler> showEvent(int id) async => await get('/event');
  Future<ResHandler> updateEvent(Map<String, dynamic> map, int id) async =>
      await put('/event/$id', FormData.fromMap(map));
}
