part of model;

class User {
    String? fullName;
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? referralCode;
    int? status;
    DateTime? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? deletedAt;
    DateTime? expiredAt;
    String? accessToken;

    User({
        this.fullName,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.referralCode,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.expiredAt,
        this.accessToken,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["full_name"],
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        referralCode: json["referral_code"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt:json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt:json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        deletedAt: json["deleted_at"],
        expiredAt: json["expired_at"],
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "referral_code": referralCode,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at":updatedAt!= null ? updatedAt!.toIso8601String() : null,
        "deleted_at": deletedAt,
        "expired_at": expiredAt,
        "access_token": accessToken,
    };
}
