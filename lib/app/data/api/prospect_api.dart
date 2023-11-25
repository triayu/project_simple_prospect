part of api;

class ProspectApi extends Fetch {
  Future<ResHandler> getProspect() async => await get('/contact-category/1');
  
}
