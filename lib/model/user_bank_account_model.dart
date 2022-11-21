class UserBankAccountModel {
  bool success;
  List<Data> data;

  UserBankAccountModel({this.success, this.data});

  UserBankAccountModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String customerId;
  String bankId;
  String accountName;
  String accountNumber;
  String isPrimary;
  String createdAt;
  String updatedAt;
  Bank bank;

  Data(
      {this.id,
      this.customerId,
      this.bankId,
      this.accountName,
      this.accountNumber,
      this.isPrimary,
      this.createdAt,
      this.updatedAt,
      this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["customer_id"] is String) this.customerId = json["customer_id"];
    if (json["bank_id"] is String) this.bankId = json["bank_id"];
    if (json["account_name"] is String) this.accountName = json["account_name"];
    if (json["account_number"] is String)
      this.accountNumber = json["account_number"];
    if (json["is_primary"] is String) this.isPrimary = json["is_primary"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["bank"] is Map)
      this.bank = json["bank"] == null ? null : Bank.fromJson(json["bank"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["customer_id"] = this.customerId;
    data["bank_id"] = this.bankId;
    data["account_name"] = this.accountName;
    data["account_number"] = this.accountNumber;
    data["is_primary"] = this.isPrimary;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if (this.bank != null) data["bank"] = this.bank.toJson();
    return data;
  }
}

class Bank {
  int id;
  String name;
  String code;
  String createdAt;
  String updatedAt;

  Bank({this.id, this.name, this.code, this.createdAt, this.updatedAt});

  Bank.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["code"] is String) this.code = json["code"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["code"] = this.code;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
