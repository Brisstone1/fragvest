class PaystackBankListModel {
  bool success;
  List<Data> data;

  PaystackBankListModel({this.success, this.data});

  PaystackBankListModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.data != null)
      data["data"] = this.data.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  String name;
  String slug;
  String code;
  String longcode;
  dynamic gateway;
  bool payWithBank;
  bool active;
  bool isDeleted;
  String country;
  String currency;
  String type;
  int id;
  String createdAt;
  String updatedAt;

  Data(
      {this.name,
      this.slug,
      this.code,
      this.longcode,
      this.gateway,
      this.payWithBank,
      this.active,
      this.isDeleted,
      this.country,
      this.currency,
      this.type,
      this.id,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) this.name = json["name"];
    if (json["slug"] is String) this.slug = json["slug"];
    if (json["code"] is String) this.code = json["code"];
    if (json["longcode"] is String) this.longcode = json["longcode"];
    this.gateway = json["gateway"];
    if (json["pay_with_bank"] is bool) this.payWithBank = json["pay_with_bank"];
    if (json["active"] is bool) this.active = json["active"];
    if (json["is_deleted"] is bool) this.isDeleted = json["is_deleted"];
    if (json["country"] is String) this.country = json["country"];
    if (json["currency"] is String) this.currency = json["currency"];
    if (json["type"] is String) this.type = json["type"];
    if (json["id"] is int) this.id = json["id"];
    if (json["createdAt"] is String) this.createdAt = json["createdAt"];
    if (json["updatedAt"] is String) this.updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["slug"] = this.slug;
    data["code"] = this.code;
    data["longcode"] = this.longcode;
    data["gateway"] = this.gateway;
    data["pay_with_bank"] = this.payWithBank;
    data["active"] = this.active;
    data["is_deleted"] = this.isDeleted;
    data["country"] = this.country;
    data["currency"] = this.currency;
    data["type"] = this.type;
    data["id"] = this.id;
    data["createdAt"] = this.createdAt;
    data["updatedAt"] = this.updatedAt;
    return data;
  }
}
