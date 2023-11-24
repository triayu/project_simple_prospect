part of api;

class MessageTemplateApi extends Fetch {
  Future<ResHandler> getMessageTemplate() async => await get('/message-template');
  Future<ResHandler> getMessageTemplateById(int id) async => await get('/message-template/$id');
  Future<ResHandler> createMessageTemplate(Map<String, dynamic> data) async =>
      await post('/message-template', FormData.fromMap(data));

 Future<ResHandler> deleteMessageTemplate(int id) async => await delete('/message-template/$id');
  Future<ResHandler> updateMessageTemplate(Map<String, dynamic> map, int id) async =>
      await put('/message-template/$id', FormData.fromMap(map));
}
