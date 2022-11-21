class TransactionHistoryModel {
  bool success;
  List<Data> data;

  TransactionHistoryModel({this.success, this.data});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String type;
  String userId;
  String propertyId;
  String amount;
  String duration;
  String charges;
  dynamic frag;
  String updatedAt;
  String date;
  Property property;

  Data(
      {this.id,
      this.type,
      this.userId,
      this.propertyId,
      this.amount,
      this.duration,
      this.charges,
      this.frag,
      this.updatedAt,
      this.date,
      this.property});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["user_id"] is String) this.userId = json["user_id"];
    if (json["property_id"] is String) this.propertyId = json["property_id"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["duration"] is String) this.duration = json["duration"];
    if (json["charges"] is String) this.charges = json["charges"];
    this.frag = json["frag"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["date"] is String) this.date = json["date"];
    if (json["property"] is Map)
      this.property =
          json["property"] == null ? null : Property.fromJson(json["property"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["type"] = this.type;
    data["user_id"] = this.userId;
    data["property_id"] = this.propertyId;
    data["amount"] = this.amount;
    data["duration"] = this.duration;
    data["charges"] = this.charges;
    data["frag"] = this.frag;
    data["updated_at"] = this.updatedAt;
    data["date"] = this.date;
    if (this.property != null) data["property"] = this.property.toJson();
    return data;
  }
}

class Property {
  int id;
  String propertyImage;
  String tokenId;

  Property({this.id, this.propertyImage, this.tokenId});

  Property.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["property_image"] is String)
      this.propertyImage = json["property_image"];
    if (json["token_id"] is String) this.tokenId = json["token_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["property_image"] = this.propertyImage;
    data["token_id"] = this.tokenId;
    return data;
  }
}
