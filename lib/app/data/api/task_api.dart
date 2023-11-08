part of api;

class TaskApi extends Fetch {
  Future<ResHandler> getTask() async => await get('/task');
}
