part of api;

class MessageApi extends Fetch {
  Future<ResHandler> getMessage() async => await get('/message');
  Future<ResHandler> postMessage(Map<String, dynamic> data) async =>
      await post('/message', FormData.fromMap(data));

 Future<ResHandler> deleteMessage(int id) async => await delete('/message/$id');
  Future<ResHandler> updateMessage(Map<String, dynamic> map, int id) async =>
      await put('/message/$id', FormData.fromMap(map));
}
