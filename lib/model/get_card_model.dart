class GetCardModel {
  bool success;
  List<Data> data;

  GetCardModel({this.success, this.data});

  GetCardModel.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String cardNumber;
  String cardCvv;
  String cardExpiryDate;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.userId,
      this.cardNumber,
      this.cardCvv,
      this.cardExpiryDate,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["user_id"] is String) this.userId = json["user_id"];
    if (json["card_number"] is String) this.cardNumber = json["card_number"];
    if (json["card_cvv"] is String) this.cardCvv = json["card_cvv"];
    if (json["card_expiry_date"] is String)
      this.cardExpiryDate = json["card_expiry_date"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["card_number"] = this.cardNumber;
    data["card_cvv"] = this.cardCvv;
    data["card_expiry_date"] = this.cardExpiryDate;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
