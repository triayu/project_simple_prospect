part of api;

class TaskApi extends Fetch {
  Future<ResHandler> getTask() async => await get('/task');
  Future<ResHandler> deleteTask(int id) async => await delete('/task/$id');
}
