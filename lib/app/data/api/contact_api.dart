part of api;

class ContactApi extends Fetch {
  Future<ResHandler> getListContact() async => await get('/contact');
  Future<ResHandler> deleteContact(int id) async => await delete('/contact/$id');
  // Selalu isiin formdata from mapppp
  Future<ResHandler> createContact(Map<String, dynamic> map) async {
    return await post('/contact', FormData.fromMap(map));
  }

  Future<ResHandler> updateContact(Map<String, dynamic> map, int id) async =>
      await put('/contact/$id', FormData.fromMap(map));

  // Category Api
  Future<ResHandler> getCategoryContact() async {
    return await get('/category');
  }
}
