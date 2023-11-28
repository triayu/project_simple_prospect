part of api;

class FeedbackApi extends Fetch {
  Future<ResHandler> getFeedback() async => await get('/feedback');
  Future<ResHandler> deleteFeedback(int id) async => await delete('/feedback/$id');
  Future<ResHandler> postFeedback(Map<String, dynamic> data) async => await post('/feedback', FormData.fromMap(data));
  Future<ResHandler> postRatingFeedback(Map<String, dynamic> data) async => await post('/feedback', data);
}
