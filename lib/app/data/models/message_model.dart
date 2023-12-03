class MessageModel {
    int? id;
    int? userId;
    String? messageTemplateId;
    String? nameContact;
    String? phoneNumber;
    String? message;
    int? status;
    String? attachment;

    MessageModel({
       this.id,
       this.userId,
       this.messageTemplateId,
       this.nameContact,
       this.phoneNumber,
       this.message,
       this.status,
       this.attachment,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        userId: json["user_id"],
        messageTemplateId: json["message_template_id"],
        nameContact: json["name_contact"],
        phoneNumber: json["phone_number"],
        message: json["message"],
        status: json["status"],
        attachment: json["attachment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "message_template_id": messageTemplateId,
        "name_contact": nameContact,
        "phone_number": phoneNumber,
        "message": message,
        "status": status,
        "attachment": attachment,
    };
}
