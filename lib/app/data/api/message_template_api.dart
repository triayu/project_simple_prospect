part of api;

class MessageTemplateApi extends Fetch {
  Future<ResHandler> getMessageTemplate() async => await get('/message-template');
  Future<ResHandler> getMessageTemplateById(int id) async => await get('/message-template/$id');
  Future<ResHandler> createMessageTemplate(Map<String, dynamic> data) async =>
      await post('/message-template', FormData.fromMap(data));
}
