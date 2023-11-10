part of api;

class TaskApi extends Fetch {
  Future<ResHandler> getTask() async => await get('/task');
  // ini cntohnya kan udah jelas 
  
  Future<ResHandler> deleteTask(int id) async => await delete('/task/$id');
  Future<ResHandler> postTask(Map<String, dynamic> data) async => await post('/task', FormData.fromMap(data));
}
