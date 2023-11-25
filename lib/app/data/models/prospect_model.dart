class ProspectModel {
    int? contactId;
    String? contactName;
    int? contactCategoryId;
    String? categoryName;

    ProspectModel({
         this.contactId,
         this.contactName,
         this.contactCategoryId,
         this.categoryName,
    });

    factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
        contactId: json["contact_id"],
        contactName: json["contact_name"],
        contactCategoryId: json["contact_category_id"],
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "contact_id": contactId,
        "contact_name": contactName,
        "contact_category_id": contactCategoryId,
        "category_name":categoryName,
    };
}
