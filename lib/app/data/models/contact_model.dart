part of model;

class ContactModel {
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? homeNumber;
  String? workNumber;
  String? email;

  ContactModel({
    this.id,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.homeNumber,
    this.workNumber,
    this.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      userId: json['user_id'],
      userFirstName: json['user_first_name'],
      userLastName: json['user_last_name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      homeNumber: json['homeNumber'],
      workNumber: json['workNumber'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['homeNumber'] = this.homeNumber;
    data['workNumber'] = this.workNumber;
    data['email'] = this.email;
    return data;
  }
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
}

