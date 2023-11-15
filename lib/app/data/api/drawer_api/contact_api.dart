part of api;

class ContactApi extends Fetch {
  Future<ResHandler> getListContact() async => await get('/contact');
   Future<ResHandler> deleteContact(int id) async => await delete('/contact/$id');
}
