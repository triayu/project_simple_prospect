part of api;

class GoalApi extends Fetch {
  Future<ResHandler> getGoal() async => await get('/dashboard/goal');
}