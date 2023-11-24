part of api;

class ContactApi extends Fetch {
  Future<ResHandler> getListContact() async => await get('/contact');
  Future<ResHandler> deleteContact(int id) async => await delete('/contact/$id');
  Future<ResHandler> createContact(Map<String, dynamic> date) async {
    return await post('/contact', data);
  }

  Future<ResHandler> updateContact(Map<String, dynamic> map, int id) async =>
      await put('/contact/$id', FormData.fromMap(map));

  // Category Api
  Future<ResHandler> getCategoryContact() async {
    return await get('/category');
  }
}
