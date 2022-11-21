class AllPropertiesModel {
  bool success;
  List<Data> data;
  Page page;

  AllPropertiesModel({this.success, this.data, this.page});

  AllPropertiesModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    if (json["page"] is Map)
      this.page = json["page"] == null ? null : Page.fromJson(json["page"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.data != null)
      data["data"] = this.data.map((e) => e.toJson()).toList();
    if (this.page != null) data["page"] = this.page.toJson();
    return data;
  }
}

class Page {
  bool hasPages;
  int perPage;
  int curPage;
  int lastPage;

  Page({this.hasPages, this.perPage, this.curPage, this.lastPage});

  Page.fromJson(Map<String, dynamic> json) {
    if (json["has_pages"] is bool) this.hasPages = json["has_pages"];
    if (json["per_page"] is int) this.perPage = json["per_page"];
    if (json["cur_page"] is int) this.curPage = json["cur_page"];
    if (json["last_page"] is int) this.lastPage = json["last_page"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["has_pages"] = this.hasPages;
    data["per_page"] = this.perPage;
    data["cur_page"] = this.curPage;
    data["last_page"] = this.lastPage;
    return data;
  }
}

class Data {
  int id;
  String tokenId;
  String type;
  String propertyAddress;
  String costPrice;
  String longCoordinate;
  String latCoordinate;
  String propertyDescription;
  int negotiable;
  String roi;
  String fragPrice;
  String rentDuration;
  String state;
  String zipcode;
  int assignedTo;
  int uploadedBy;
  String createdAt;
  String updatedAt;
  int userUpload;
  String status;
  int outrightOwner;
  String propertyType;
  int deletedBy;
  String amount;
  int inWatchlist;
  int inPortfolio;
  String propertyMapLocation;
  List<String> propertyImages;
  List<String> propertyFeatures;
  PropertyAgent propertyAgent;
  bool hasReviewed;
  List<Reviews> reviews;
  PropertyStats propertyStats;
  bool avaialble;
  String mFragPrice;
  DState dState;

  Data(
      {this.id,
      this.tokenId,
      this.type,
      this.propertyAddress,
      this.costPrice,
      this.longCoordinate,
      this.latCoordinate,
      this.propertyDescription,
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
      this.propertyType,
      this.deletedBy,
      this.amount,
      this.inWatchlist,
      this.inPortfolio,
      this.propertyMapLocation,
      this.propertyImages,
      this.propertyFeatures,
      this.propertyAgent,
      this.hasReviewed,
      this.reviews,
      this.propertyStats,
      this.avaialble,
      this.mFragPrice,
      this.dState});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["property_description"] is String)
      this.propertyDescription = json["property_description"];
    if (json["negotiable"] is int) this.negotiable = json["negotiable"];
    if (json["roi"] is String) this.roi = json["roi"];
    if (json["frag_price"] is String) this.fragPrice = json["frag_price"];
    if (json["rent_duration"] is String)
      this.rentDuration = json["rent_duration"];
    if (json["state"] is String) this.state = json["state"];
    if (json["zipcode"] is String) this.zipcode = json["zipcode"];
    if (json["assigned_to"] is int) this.assignedTo = json["assigned_to"];
    if (json["uploaded_by"] is int) this.uploadedBy = json["uploaded_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["user_upload"] is int) this.userUpload = json["user_upload"];
    if (json["status"] is String) this.status = json["status"];
    if (json["outright_owner"] is int)
      this.outrightOwner = json["outright_owner"];
    if (json["property_type"] is String)
      this.propertyType = json["property_type"];
    if (json["deleted_by"] is int) this.deletedBy = json["deleted_by"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["in_watchlist"] is int) this.inWatchlist = json["in_watchlist"];
    if (json["in_portfolio"] is int) this.inPortfolio = json["in_portfolio"];
    if (json["property_map_location"] is String)
      this.propertyMapLocation = json["property_map_location"];
    if (json["property_images"] is List)
      this.propertyImages = json["property_images"] == null
          ? null
          : List<String>.from(json["property_images"]);
    if (json["property_features"] is List)
      this.propertyFeatures = json["property_features"] == null
          ? null
          : List<String>.from(json["property_features"]);
    if (json["property_agent"] is Map)
      this.propertyAgent = json["property_agent"] == null
          ? null
          : PropertyAgent.fromJson(json["property_agent"]);
    if (json["has_reviewed"] is bool) this.hasReviewed = json["has_reviewed"];
    if (json["reviews"] is List)
      this.reviews = json["reviews"] == null
          ? null
          : (json["reviews"] as List).map((e) => Reviews.fromJson(e)).toList();
    if (json["property_stats"] is Map)
      this.propertyStats = json["property_stats"] == null
          ? null
          : PropertyStats.fromJson(json["property_stats"]);
    if (json["avaialble"] is bool) this.avaialble = json["avaialble"];
    if (json["m_frag_price"] is String) this.mFragPrice = json["m_frag_price"];
    if (json["d_state"] is Map)
      this.dState =
          json["d_state"] == null ? null : DState.fromJson(json["d_state"]);
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
    data["property_description"] = this.propertyDescription;
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
    data["property_type"] = this.propertyType;
    data["deleted_by"] = this.deletedBy;
    data["amount"] = this.amount;
    data["in_watchlist"] = this.inWatchlist;
    data["in_portfolio"] = this.inPortfolio;
    data["property_map_location"] = this.propertyMapLocation;
    if (this.propertyImages != null)
      data["property_images"] = this.propertyImages;
    if (this.propertyFeatures != null)
      data["property_features"] = this.propertyFeatures;
    if (this.propertyAgent != null)
      data["property_agent"] = this.propertyAgent.toJson();
    data["has_reviewed"] = this.hasReviewed;
    if (this.reviews != null)
      data["reviews"] = this.reviews.map((e) => e.toJson()).toList();
    if (this.propertyStats != null)
      data["property_stats"] = this.propertyStats.toJson();
    data["avaialble"] = this.avaialble;
    data["m_frag_price"] = this.mFragPrice;
    if (this.dState != null) data["d_state"] = this.dState.toJson();
    return data;
  }
}

class DState {
  int id;
  String name;
  int countryId;
  String createdAt;
  String updatedAt;

  DState({this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  DState.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["country_id"] is int) this.countryId = json["country_id"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["country_id"] = this.countryId;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}

class PropertyStats {
  String investors;
  String availableFrags;

  PropertyStats({this.investors, this.availableFrags});

  PropertyStats.fromJson(Map<String, dynamic> json) {
    if (json["investors"] is String) this.investors = json["investors"];
    if (json["available_frags"] is String)
      this.availableFrags = json["available_frags"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["investors"] = this.investors;
    data["available_frags"] = this.availableFrags;
    return data;
  }
}

class Reviews {
  String message;
  String stars;
  String date;
  User user;

  Reviews({this.message, this.stars, this.date, this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["stars"] is String) this.stars = json["stars"];
    if (json["date"] is String) this.date = json["date"];
    if (json["user"] is Map)
      this.user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["message"] = this.message;
    data["stars"] = this.stars;
    data["date"] = this.date;
    if (this.user != null) data["user"] = this.user.toJson();
    return data;
  }
}

class User {
  String firstName;
  String lastName;
  String profileImg;

  User({this.firstName, this.lastName, this.profileImg});

  User.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["profile_img"] = this.profileImg;
    return data;
  }
}

class PropertyAgent {
  String firstName;
  String lastName;
  String phone;
  String email;
  String profileImg;
  Availability availability;

  PropertyAgent(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.profileImg,
      this.availability});

  PropertyAgent.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["phone"] is String) this.phone = json["phone"];
    if (json["email"] is String) this.email = json["email"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
    if (json["availability"] is Map)
      this.availability = json["availability"] == null
          ? null
          : Availability.fromJson(json["availability"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["profile_img"] = this.profileImg;
    if (this.availability != null)
      data["availability"] = this.availability.toJson();
    return data;
  }
}

class Availability {
  bool available;
  List<String> availableDate;
  List<int> availableTime;

  Availability({this.available, this.availableDate, this.availableTime});

  Availability.fromJson(Map<String, dynamic> json) {
    if (json["available"] is bool) this.available = json["available"];
    if (json["available_date"] is List)
      this.availableDate = json["available_date"] == null
          ? null
          : List<String>.from(json["available_date"]);
    if (json["available_time"] is List)
      this.availableTime = json["available_time"] == null
          ? null
          : List<int>.from(json["available_time"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["available"] = this.available;
    if (this.availableDate != null) data["available_date"] = this.availableDate;
    if (this.availableTime != null) data["available_time"] = this.availableTime;
    return data;
  }
}
