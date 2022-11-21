class InvestOrderHistoryModel {
  bool success;
  List<Data> data;

  InvestOrderHistoryModel({this.success, this.data});

  InvestOrderHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int portfolioId;
  String orderType;
  String amount;
  String discount;
  String frag;
  String status;
  String createdAt;
  String updatedAt;
  Portfolio portfolio;

  Data(
      {this.id,
      this.portfolioId,
      this.orderType,
      this.amount,
      this.discount,
      this.frag,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.portfolio});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["portfolio_id"] is int) this.portfolioId = json["portfolio_id"];
    if (json["order_type"] is String) this.orderType = json["order_type"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["discount"] is String) this.discount = json["discount"];
    if (json["frag"] is String) this.frag = json["frag"];
    if (json["status"] is String) this.status = json["status"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["portfolio"] is Map)
      this.portfolio = json["portfolio"] == null
          ? null
          : Portfolio.fromJson(json["portfolio"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["portfolio_id"] = this.portfolioId;
    data["order_type"] = this.orderType;
    data["amount"] = this.amount;
    data["discount"] = this.discount;
    data["frag"] = this.frag;
    data["status"] = this.status;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if (this.portfolio != null) data["portfolio"] = this.portfolio.toJson();
    return data;
  }
}

class Portfolio {
  int id;
  String type;
  int userId;
  int propertyId;
  String amount;
  dynamic duration;
  String charges;
  String frag;
  String createdAt;
  String updatedAt;
  Property property;

  Portfolio(
      {this.id,
      this.type,
      this.userId,
      this.propertyId,
      this.amount,
      this.duration,
      this.charges,
      this.frag,
      this.createdAt,
      this.updatedAt,
      this.property});

  Portfolio.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["user_id"] is int) this.userId = json["user_id"];
    if (json["property_id"] is int) this.propertyId = json["property_id"];
    if (json["amount"] is String) this.amount = json["amount"];
    this.duration = json["duration"];
    if (json["charges"] is String) this.charges = json["charges"];
    if (json["frag"] is String) this.frag = json["frag"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
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
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if (this.property != null) data["property"] = this.property.toJson();
    return data;
  }
}

class Property {
  int id;
  String tokenId;
  String type;
  String propertyAddress;
  String costPrice;
  String longCoordinate;
  String latCoordinate;
  List<String> propertyDetails;
  String propertyDescription;
  String propertyImage;
  dynamic negotiable;
  String roi;
  String fragPrice;
  dynamic rentDuration;
  String state;
  String zipcode;
  dynamic assignedTo;
  int uploadedBy;
  String createdAt;
  String updatedAt;
  int userUpload;
  String status;
  dynamic outrightOwner;
  int isDeleted;
  String propertyType;
  int deletedBy;
  List<String> propertyImages;

  Property(
      {this.id,
      this.tokenId,
      this.type,
      this.propertyAddress,
      this.costPrice,
      this.longCoordinate,
      this.latCoordinate,
      this.propertyDetails,
      this.propertyDescription,
      this.propertyImage,
      this.negotiable,
      this.roi,
      this.fragPrice,
      this.rentDuration,
      this.state,
      this.zipcode,
      this.assignedTo,
      this.uploadedBy,
      this.createdAt,
      this.updatedAt,
      this.userUpload,
      this.status,
      this.outrightOwner,
      this.isDeleted,
      this.propertyType,
      this.deletedBy,
      this.propertyImages});

  Property.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["token_id"] is String) this.tokenId = json["token_id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["property_address"] is String)
      this.propertyAddress = json["property_address"];
    if (json["cost_price"] is String) this.costPrice = json["cost_price"];
    if (json["long_coordinate"] is String)
      this.longCoordinate = json["long_coordinate"];
    if (json["lat_coordinate"] is String)
      this.latCoordinate = json["lat_coordinate"];
    if (json["property_details"] is List)
      this.propertyDetails = json["property_details"] == null
          ? null
          : List<String>.from(json["property_details"]);
    if (json["property_description"] is String)
      this.propertyDescription = json["property_description"];
    if (json["property_image"] is String)
      this.propertyImage = json["property_image"];
    this.negotiable = json["negotiable"];
    if (json["roi"] is String) this.roi = json["roi"];
    if (json["frag_price"] is String) this.fragPrice = json["frag_price"];
    this.rentDuration = json["rent_duration"];
    if (json["state"] is String) this.state = json["state"];
    if (json["zipcode"] is String) this.zipcode = json["zipcode"];
    this.assignedTo = json["assigned_to"];
    if (json["uploaded_by"] is int) this.uploadedBy = json["uploaded_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["user_upload"] is int) this.userUpload = json["user_upload"];
    if (json["status"] is String) this.status = json["status"];
    this.outrightOwner = json["outright_owner"];
    if (json["is_deleted"] is int) this.isDeleted = json["is_deleted"];
    if (json["property_type"] is String)
      this.propertyType = json["property_type"];
    if (json["deleted_by"] is int) this.deletedBy = json["deleted_by"];
    if (json["property_images"] is List)
      this.propertyImages = json["property_images"] == null
          ? null
          : List<String>.from(json["property_images"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["token_id"] = this.tokenId;
    data["type"] = this.type;
    data["property_address"] = this.propertyAddress;
    data["cost_price"] = this.costPrice;
    data["long_coordinate"] = this.longCoordinate;
    data["lat_coordinate"] = this.latCoordinate;
    if (this.propertyDetails != null)
      data["property_details"] = this.propertyDetails;
    data["property_description"] = this.propertyDescription;
    data["property_image"] = this.propertyImage;
    data["negotiable"] = this.negotiable;
    data["roi"] = this.roi;
    data["frag_price"] = this.fragPrice;
    data["rent_duration"] = this.rentDuration;
    data["state"] = this.state;
    data["zipcode"] = this.zipcode;
    data["assigned_to"] = this.assignedTo;
    data["uploaded_by"] = this.uploadedBy;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["user_upload"] = this.userUpload;
    data["status"] = this.status;
    data["outright_owner"] = this.outrightOwner;
    data["is_deleted"] = this.isDeleted;
    data["property_type"] = this.propertyType;
    data["deleted_by"] = this.deletedBy;
    if (this.propertyImages != null)
      data["property_images"] = this.propertyImages;
    return data;
  }
}
