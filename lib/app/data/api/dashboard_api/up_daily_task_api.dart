part of api;

class UpDailyTaskApi extends Fetch {
  Future<ResHandler> getUpDailyTask() async => await get('/dashboard/up-daily-task');
}
// 