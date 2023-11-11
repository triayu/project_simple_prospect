part of api;

class PhoneBookApi extends Fetch {
  Future<ResHandler> getPhoneBook() async {
    return await get('phoneBook');
  }

  Future<ResHandler> addPhoneBook(Map<String, dynamic> data) async {
    return await post('/phonebook', data);
  }
}
