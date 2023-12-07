part of api;

class ProspectApi extends Fetch {
  Future<ResHandler> getCatProspect() async => await get('/contact-category/1');
}
