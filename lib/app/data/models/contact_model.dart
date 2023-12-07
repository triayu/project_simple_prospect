part of model;

class ContactModel {
  int? id;
  int? contactId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? phoneNumber;
  String? homeNumber;
  String? workNumber;
  String? email;
  String? categoryId;
  String? categoryName;

  ContactModel({
    this.id,
    this.contactId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.homeNumber,
    this.workNumber,
    this.email,
    this.categoryId,
    this.categoryName,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        contactId: json["contact_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        homeNumber: json["home_number"],
        workNumber: json["work_number"],
        email: json["email"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_id": contactId,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "home_number": homeNumber,
        "work_number": workNumber,
        "email": email,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}

class CategoryContactModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? categoryName;

  CategoryContactModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.categoryName,
  });

  factory CategoryContactModel.fromJson(Map<String, dynamic> json) => CategoryContactModel(
        id: json["id"],
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "category_name": categoryName,
      };

  @override
  String toString() {
    return 'CategoryContactModel(id: $id, userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, categoryName: $categoryName)';
  }
}
