part of api;

class EventApi extends Fetch {
  Future<ResHandler> getEvent() async => await get('/event');
  Future<ResHandler> deleteEvent(int id) async => await delete('/event/$id');
  Future<ResHandler> addEvent(Map<String, dynamic> date) async {return await post('/event', data);}
}
