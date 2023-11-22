part of api;

class FeedbackApi extends Fetch {
  Future<ResHandler> getFeedback() async => await get('/feedback');
  
  // Future<ResHandler> addFeedback(Map<String, dynamic> date) async {return await post('/feedback', data);}
   
}
