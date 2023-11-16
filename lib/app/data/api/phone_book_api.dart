part of api;

class PhoneBookApi extends Fetch {
  // Api Untuk Get Phone Book
  Future<ResHandler> getPhoneBook() async {
    return await get('phoneBook');
  }
  // Api Untuk Post Phone Book
  Future<ResHandler> addPhoneBook(Map<String, dynamic> data) async {
    return await post('/phonebook', data);
  }

  // Nah trus untuk api category phone book truh lagi dbwahnya,
 // jangan dsini buat category api nya,
}
