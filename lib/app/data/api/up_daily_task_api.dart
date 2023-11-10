part of api;

class UpDailyTaskeApi extends Fetch {
  Future<ResHandler> getUpDailyTask() async => await get('/dashboard/up-daily-task');
}
// 