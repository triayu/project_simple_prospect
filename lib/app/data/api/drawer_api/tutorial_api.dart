part of api;

class TutorialVideoApi extends Fetch {
  Future<ResHandler> getTutorial() async => await get('/tutorial');
}
