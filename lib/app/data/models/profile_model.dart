class ProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? referralCode;
  int? status;
  dynamic fotoProfile;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic expiredAt;

  ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.referralCode,
    this.status,
    this.fotoProfile,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.expiredAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        referralCode: json["referral_code"],
        status: json["status"],
        fotoProfile: json["foto_profile"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        expiredAt: json["expired_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "referral_code": referralCode,
        "status": status,
        "foto_profile": fotoProfile,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "expired_at": expiredAt,
      };
}
