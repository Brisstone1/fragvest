class DashboardModel {
  bool success;
  Data data;

  DashboardModel({this.success, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["data"] is Map)
      this.data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.data != null) data["data"] = this.data.toJson();
    return data;
  }
}

class Data {
  User user;
  Trending trending;
  List<Portfolio> portfolio;
  Latest latest;
  // List<Posts> posts;

  Data({
    this.user,
    this.trending,
    this.portfolio,
    this.latest,
    // this.posts
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map)
      this.user = json["user"] == null ? null : User.fromJson(json["user"]);
    if (json["trending"] is Map)
      this.trending =
          json["trending"] == null ? null : Trending.fromJson(json["trending"]);
    if (json["portfolio"] is List)
      this.portfolio = json["portfolio"] == null
          ? null
          : (json["portfolio"] as List)
              .map((e) => Portfolio.fromJson(e))
              .toList();
    if (json["latest"] is Map)
      this.latest =
          json["latest"] == null ? null : Latest.fromJson(json["latest"]);
    // if (json["posts"] is List)
    //   this.posts = json["posts"] == null
    //       ? null
    //       : (json["posts"] as List).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) data["user"] = this.user.toJson();
    if (this.trending != null) data["trending"] = this.trending.toJson();
    if (this.portfolio != null)
      data["portfolio"] = this.portfolio.map((e) => e.toJson()).toList();
    if (this.latest != null) data["latest"] = this.latest.toJson();
    // if (this.posts != null)
    //   data["posts"] = this.posts.map((e) => e.toJson()).toList();
    return data;
  }
}

// class Posts {
//   String postImage;
//   String postTitle;
//   String postLink;

//   Posts({this.postImage, this.postTitle, this.postLink});

//   Posts.fromJson(Map<String, dynamic> json) {
//     if (json["post_image"] is String) this.postImage = json["post_image"];
//     if (json["post_title"] is String) this.postTitle = json["post_title"];
//     if (json["post_link"] is String) this.postLink = json["post_link"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["post_image"] = this.postImage;
//     data["post_title"] = this.postTitle;
//     data["post_link"] = this.postLink;
//     return data;
//   }
// }

class Latest {
  List<Properties1> properties;
  Page1 page;

  Latest({this.properties, this.page});

  Latest.fromJson(Map<String, dynamic> json) {
    if (json["properties"] is List)
      this.properties = json["properties"] == null
          ? null
          : (json["properties"] as List)
              .map((e) => Properties1.fromJson(e))
              .toList();
    if (json["page"] is Map)
      this.page = json["page"] == null ? null : Page1.fromJson(json["page"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.properties != null)
      data["properties"] = this.properties.map((e) => e.toJson()).toList();
    if (this.page != null) data["page"] = this.page.toJson();
    return data;
  }
}

class Page1 {
  bool hasPages;
  num perPage;
  num curPage;
  num lastPage;

  Page1({this.hasPages, this.perPage, this.curPage, this.lastPage});

  Page1.fromJson(Map<String, dynamic> json) {
    if (json["has_pages"] is bool) this.hasPages = json["has_pages"];
    if (json["per_page"] is num) this.perPage = json["per_page"];
    if (json["cur_page"] is num) this.curPage = json["cur_page"];
    if (json["last_page"] is num) this.lastPage = json["last_page"];
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

class Properties1 {
  num id;
  String tokenId;
  String type;
  String propertyAddress;
  String costPrice;
  String longCoordinate;
  String latCoordinate;
  String propertyDescription;
  num negotiable;
  dynamic roi;
  dynamic fragPrice;
  String rentDuration;
  String state;
  String zipcode;
  num assignedTo;
  num uploadedBy;
  String createdAt;
  String updatedAt;
  num userUpload;
  String status;
  dynamic outrightOwner;
  String propertyType;
  num deletedBy;
  String amount;
  num inWatchlist;
  num inPortfolio;
  String propertyMapLocation;
  List<String> propertyImages;
  List<String> propertyFeatures;
  PropertyAgent2 propertyAgent;
  bool hasReviewed;
  List<dynamic> reviews;
  String propertyStats;
  bool avaialble;
  dynamic mFragPrice;
  DState2 dState;

  Properties1(
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

  Properties1.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
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
    if (json["negotiable"] is num) this.negotiable = json["negotiable"];
    this.roi = json["roi"];
    this.fragPrice = json["frag_price"];
    if (json["rent_duration"] is String)
      this.rentDuration = json["rent_duration"];
    if (json["state"] is String) this.state = json["state"];
    if (json["zipcode"] is String) this.zipcode = json["zipcode"];
    if (json["assigned_to"] is num) this.assignedTo = json["assigned_to"];
    if (json["uploaded_by"] is num) this.uploadedBy = json["uploaded_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["user_upload"] is num) this.userUpload = json["user_upload"];
    if (json["status"] is String) this.status = json["status"];
    this.outrightOwner = json["outright_owner"];
    if (json["property_type"] is String)
      this.propertyType = json["property_type"];
    if (json["deleted_by"] is num) this.deletedBy = json["deleted_by"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["in_watchlist"] is num) this.inWatchlist = json["in_watchlist"];
    if (json["in_portfolio"] is num) this.inPortfolio = json["in_portfolio"];
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
          : PropertyAgent2.fromJson(json["property_agent"]);
    if (json["has_reviewed"] is bool) this.hasReviewed = json["has_reviewed"];
    if (json["reviews"] is List) this.reviews = json["reviews"] ?? [];
    if (json["property_stats"] is String)
      this.propertyStats = json["property_stats"];
    if (json["avaialble"] is bool) this.avaialble = json["avaialble"];
    this.mFragPrice = json["m_frag_price"];
    if (json["d_state"] is Map)
      this.dState =
          json["d_state"] == null ? null : DState2.fromJson(json["d_state"]);
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
    if (this.reviews != null) data["reviews"] = this.reviews;
    data["property_stats"] = this.propertyStats;
    data["avaialble"] = this.avaialble;
    data["m_frag_price"] = this.mFragPrice;
    if (this.dState != null) data["d_state"] = this.dState.toJson();
    return data;
  }
}

class DState2 {
  num id;
  String name;
  num countryId;
  String createdAt;
  String updatedAt;

  DState2({this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  DState2.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["country_id"] is num) this.countryId = json["country_id"];
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

class PropertyAgent2 {
  String firstName;
  String lastName;
  String phone;
  String email;
  String profileImg;
  Availability2 availability;

  PropertyAgent2(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.profileImg,
      this.availability});

  PropertyAgent2.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["phone"] is String) this.phone = json["phone"];
    if (json["email"] is String) this.email = json["email"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
    if (json["availability"] is Map)
      this.availability = json["availability"] == null
          ? null
          : Availability2.fromJson(json["availability"]);
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

class Availability2 {
  bool available;
  List<String> availableDate;
  List<num> availableTime;

  Availability2({this.available, this.availableDate, this.availableTime});

  Availability2.fromJson(Map<String, dynamic> json) {
    if (json["available"] is bool) this.available = json["available"];
    if (json["available_date"] is List)
      this.availableDate = json["available_date"] == null
          ? null
          : List<String>.from(json["available_date"]);
    if (json["available_time"] is List)
      this.availableTime = json["available_time"] == null
          ? null
          : List<num>.from(json["available_time"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["available"] = this.available;
    if (this.availableDate != null) data["available_date"] = this.availableDate;
    if (this.availableTime != null) data["available_time"] = this.availableTime;
    return data;
  }
}

class Portfolio {
  num id;
  String tokenId;
  String type;
  String propertyAddress;
  String costPrice;
  String longCoordinate;
  String latCoordinate;
  String propertyDescription;
  num negotiable;
  String roi;
  String fragPrice;
  String rentDuration;
  String state;
  String zipcode;
  num assignedTo;
  num uploadedBy;
  String createdAt;
  String updatedAt;
  num userUpload;
  String status;
  dynamic outrightOwner;
  String propertyType;
  num deletedBy;
  String amount;
  num inWatchlist;
  num inPortfolio;
  String propertyMapLocation;
  List<String> propertyImages;
  List<String> propertyFeatures;
  PropertyAgent1 propertyAgent;
  bool hasReviewed;
  List<Reviews1> reviews;
  PropertyStats1 propertyStats;
  bool avaialble;
  Report report;
  num portfolioId;
  String mFragPrice;
  DState1 dState;

  Portfolio(
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
      this.report,
      this.portfolioId,
      this.mFragPrice,
      this.dState});

  Portfolio.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
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
    if (json["negotiable"] is num) this.negotiable = json["negotiable"];
    if (json["roi"] is String) this.roi = json["roi"];
    if (json["frag_price"] is String) this.fragPrice = json["frag_price"];
    if (json["rent_duration"] is String)
      this.rentDuration = json["rent_duration"];
    if (json["state"] is String) this.state = json["state"];
    if (json["zipcode"] is String) this.zipcode = json["zipcode"];
    if (json["assigned_to"] is num) this.assignedTo = json["assigned_to"];
    if (json["uploaded_by"] is num) this.uploadedBy = json["uploaded_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["user_upload"] is num) this.userUpload = json["user_upload"];
    if (json["status"] is String) this.status = json["status"];
    this.outrightOwner = json["outright_owner"];
    if (json["property_type"] is String)
      this.propertyType = json["property_type"];
    if (json["deleted_by"] is num) this.deletedBy = json["deleted_by"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["in_watchlist"] is num) this.inWatchlist = json["in_watchlist"];
    if (json["in_portfolio"] is num) this.inPortfolio = json["in_portfolio"];
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
          : PropertyAgent1.fromJson(json["property_agent"]);
    if (json["has_reviewed"] is bool) this.hasReviewed = json["has_reviewed"];
    if (json["reviews"] is List)
      this.reviews = json["reviews"] == null
          ? null
          : (json["reviews"] as List).map((e) => Reviews1.fromJson(e)).toList();
    if (json["property_stats"] is Map)
      this.propertyStats = json["property_stats"] == null
          ? null
          : PropertyStats1.fromJson(json["property_stats"]);
    if (json["avaialble"] is bool) this.avaialble = json["avaialble"];
    if (json["report"] is Map)
      this.report =
          json["report"] == null ? null : Report.fromJson(json["report"]);
    if (json["portfolio_id"] is num) this.portfolioId = json["portfolio_id"];
    if (json["m_frag_price"] is String) this.mFragPrice = json["m_frag_price"];
    if (json["d_state"] is Map)
      this.dState =
          json["d_state"] == null ? null : DState1.fromJson(json["d_state"]);
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
    if (this.report != null) data["report"] = this.report.toJson();
    data["m_frag_price"] = this.mFragPrice;
    if (this.dState != null) data["d_state"] = this.dState.toJson();
    return data;
  }
}

class DState1 {
  num id;
  String name;
  num countryId;
  String createdAt;
  String updatedAt;

  DState1({this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  DState1.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["country_id"] is num) this.countryId = json["country_id"];
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

class Report {
  bool rented;
  bool owned;
  String investors;
  String avaialableFrags;
  String estNetYield;
  String currentNetYield;
  num currentNetYieldPercentage;
  String initialCapital;
  String initialWorthOfInv;
  String currentWorthOfInv;
  String startDate;
  String endDate;
  String currentDate;
  num daysLeft;
  String duration;
  String notice;
  String invested;

  Report(
      {this.rented,
      this.owned,
      this.investors,
      this.avaialableFrags,
      this.estNetYield,
      this.currentNetYield,
      this.currentNetYieldPercentage,
      this.initialCapital,
      this.initialWorthOfInv,
      this.currentWorthOfInv,
      this.startDate,
      this.endDate,
      this.currentDate,
      this.daysLeft,
      this.duration,
      this.notice,
      this.invested});

  Report.fromJson(Map<String, dynamic> json) {
    if (json["rented"] is bool) this.rented = json["rented"];
    if (json["owned"] is bool) this.owned = json["owned"];
    if (json["investors"] is String) this.investors = json["investors"];
    if (json["avaialable_frags"] is String)
      this.avaialableFrags = json["avaialable_frags"];
    if (json["est_net_yield"] is String)
      this.estNetYield = json["est_net_yield"];
    if (json["current_net_yield"] is String)
      this.currentNetYield = json["current_net_yield"];
    if (json["current_net_yield_percentage"] is num)
      this.currentNetYieldPercentage = json["current_net_yield_percentage"];
    if (json["initial_capital"] is String)
      this.initialCapital = json["initial_capital"];
    if (json["initial_worth_of_inv"] is String)
      this.initialWorthOfInv = json["initial_worth_of_inv"];
    if (json["current_worth_of_inv"] is String)
      this.currentWorthOfInv = json["current_worth_of_inv"];
    if (json["start_date"] is String) this.startDate = json["start_date"];
    if (json["end_date"] is String) this.endDate = json["end_date"];
    if (json["current_date"] is String) this.currentDate = json["current_date"];
    if (json["days_left"] is num) this.daysLeft = json["days_left"];
    if (json["duration"] is String) this.duration = json["duration"];
    if (json["notice"] is String) this.notice = json["notice"];
    if (json["invested"] is String) this.invested = json["invested"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["rented"] = this.rented;
    data["owned"] = this.owned;
    data["investors"] = this.investors;
    data["avaialable_frags"] = this.avaialableFrags;
    data["est_net_yield"] = this.estNetYield;
    data["current_net_yield"] = this.currentNetYield;
    data["current_net_yield_percentage"] = this.currentNetYieldPercentage;
    data["initial_capital"] = this.initialCapital;
    data["initial_worth_of_inv"] = this.initialWorthOfInv;
    data["current_worth_of_inv"] = this.currentWorthOfInv;
    data["start_date"] = this.startDate;
    data["end_date"] = this.endDate;
    data["current_date"] = this.currentDate;
    data["days_left"] = this.daysLeft;
    data["duration"] = this.duration;
    data["notice"] = this.notice;
    data["invested"] = this.invested;
    return data;
  }
}

class PropertyStats1 {
  String investors;
  String availableFrags;

  PropertyStats1({this.investors, this.availableFrags});

  PropertyStats1.fromJson(Map<String, dynamic> json) {
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

class Reviews1 {
  String message;
  String stars;
  String date;
  User2 user;

  Reviews1({this.message, this.stars, this.date, this.user});

  Reviews1.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["stars"] is String) this.stars = json["stars"];
    if (json["date"] is String) this.date = json["date"];
    if (json["user"] is Map)
      this.user = json["user"] == null ? null : User2.fromJson(json["user"]);
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

class User2 {
  String firstName;
  String lastName;
  String profileImg;

  User2({this.firstName, this.lastName, this.profileImg});

  User2.fromJson(Map<String, dynamic> json) {
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

class PropertyAgent1 {
  String firstName;
  String lastName;
  String phone;
  String email;
  String profileImg;
  Availability1 availability;

  PropertyAgent1(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.profileImg,
      this.availability});

  PropertyAgent1.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["phone"] is String) this.phone = json["phone"];
    if (json["email"] is String) this.email = json["email"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
    if (json["availability"] is Map)
      this.availability = json["availability"] == null
          ? null
          : Availability1.fromJson(json["availability"]);
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

class Availability1 {
  bool available;
  List<String> availableDate;
  List<num> availableTime;

  Availability1({this.available, this.availableDate, this.availableTime});

  Availability1.fromJson(Map<String, dynamic> json) {
    if (json["available"] is bool) this.available = json["available"];
    if (json["available_date"] is List)
      this.availableDate = json["available_date"] == null
          ? null
          : List<String>.from(json["available_date"]);
    if (json["available_time"] is List)
      this.availableTime = json["available_time"] == null
          ? null
          : List<num>.from(json["available_time"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["available"] = this.available;
    if (this.availableDate != null) data["available_date"] = this.availableDate;
    if (this.availableTime != null) data["available_time"] = this.availableTime;
    return data;
  }
}

class Trending {
  List<Properties> properties;
  Page page;

  Trending({this.properties, this.page});

  Trending.fromJson(Map<String, dynamic> json) {
    if (json["properties"] is List)
      this.properties = json["properties"] == null
          ? null
          : (json["properties"] as List)
              .map((e) => Properties.fromJson(e))
              .toList();
    if (json["page"] is Map)
      this.page = json["page"] == null ? null : Page.fromJson(json["page"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.properties != null)
      data["properties"] = this.properties.map((e) => e.toJson()).toList();
    if (this.page != null) data["page"] = this.page.toJson();
    return data;
  }
}

class Page {
  bool hasPages;
  num perPage;
  num curPage;
  num lastPage;

  Page({this.hasPages, this.perPage, this.curPage, this.lastPage});

  Page.fromJson(Map<String, dynamic> json) {
    if (json["has_pages"] is bool) this.hasPages = json["has_pages"];
    if (json["per_page"] is num) this.perPage = json["per_page"];
    if (json["cur_page"] is num) this.curPage = json["cur_page"];
    if (json["last_page"] is num) this.lastPage = json["last_page"];
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

class Properties {
  num id;
  String tokenId;
  String type;
  String propertyAddress;
  String costPrice;
  String longCoordinate;
  String latCoordinate;
  String propertyDescription;
  num negotiable;
  String roi;
  String fragPrice;
  String rentDuration;
  String state;
  String zipcode;
  num assignedTo;
  num uploadedBy;
  String createdAt;
  String updatedAt;
  num userUpload;
  String status;
  dynamic outrightOwner;
  String propertyType;
  num deletedBy;
  String amount;
  num inWatchlist;
  num inPortfolio;
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

  Properties(
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

  Properties.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
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
    if (json["negotiable"] is num) this.negotiable = json["negotiable"];
    if (json["roi"] is String) this.roi = json["roi"];
    if (json["frag_price"] is String) this.fragPrice = json["frag_price"];
    if (json["rent_duration"] is String)
      this.rentDuration = json["rent_duration"];
    if (json["state"] is String) this.state = json["state"];
    if (json["zipcode"] is String) this.zipcode = json["zipcode"];
    if (json["assigned_to"] is num) this.assignedTo = json["assigned_to"];
    if (json["uploaded_by"] is num) this.uploadedBy = json["uploaded_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["user_upload"] is num) this.userUpload = json["user_upload"];
    if (json["status"] is String) this.status = json["status"];
    this.outrightOwner = json["outright_owner"];
    if (json["property_type"] is String)
      this.propertyType = json["property_type"];
    if (json["deleted_by"] is num) this.deletedBy = json["deleted_by"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["in_watchlist"] is num) this.inWatchlist = json["in_watchlist"];
    if (json["in_portfolio"] is num) this.inPortfolio = json["in_portfolio"];
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
  num id;
  String name;
  num countryId;
  String createdAt;
  String updatedAt;

  DState({this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  DState.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["country_id"] is num) this.countryId = json["country_id"];
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
  User1 user;

  Reviews({this.message, this.stars, this.date, this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["stars"] is String) this.stars = json["stars"];
    if (json["date"] is String) this.date = json["date"];
    if (json["user"] is Map)
      this.user = json["user"] == null ? null : User1.fromJson(json["user"]);
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

class User1 {
  String firstName;
  String lastName;
  String profileImg;

  User1({this.firstName, this.lastName, this.profileImg});

  User1.fromJson(Map<String, dynamic> json) {
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
  List<num> availableTime;

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
          : List<num>.from(json["available_time"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["available"] = this.available;
    if (this.availableDate != null) data["available_date"] = this.availableDate;
    if (this.availableTime != null) data["available_time"] = this.availableTime;
    return data;
  }
}

class User {
  String firstName;
  String lastName;
  String profileImg;
  String balance;
  PortfolioStat portfolioStat;
  List<RecentTransactions> recentTransactions;

  User(
      {this.firstName,
      this.lastName,
      this.profileImg,
      this.balance,
      this.portfolioStat,
      this.recentTransactions});

  User.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
    if (json["balance"] is String) this.balance = json["balance"];
    if (json["portfolio_stat"] is Map)
      this.portfolioStat = json["portfolio_stat"] == null
          ? null
          : PortfolioStat.fromJson(json["portfolio_stat"]);
    if (json["recent_transactions"] is List)
      this.recentTransactions = json["recent_transactions"] == null
          ? null
          : (json["recent_transactions"] as List)
              .map((e) => RecentTransactions.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["profile_img"] = this.profileImg;
    data["balance"] = this.balance;
    if (this.portfolioStat != null)
      data["portfolio_stat"] = this.portfolioStat.toJson();
    if (this.recentTransactions != null)
      data["recent_transactions"] =
          this.recentTransactions.map((e) => e.toJson()).toList();
    return data;
  }
}

class RecentTransactions {
  num id;
  String type;
  num userId;
  num propertyId;
  String amount;
  String duration;
  String charges;
  String frag;
  String createdAt;
  String updatedAt;

  RecentTransactions(
      {this.id,
      this.type,
      this.userId,
      this.propertyId,
      this.amount,
      this.duration,
      this.charges,
      this.frag,
      this.createdAt,
      this.updatedAt});

  RecentTransactions.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) this.id = json["id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["user_id"] is num) this.userId = json["user_id"];
    if (json["property_id"] is num) this.propertyId = json["property_id"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["duration"] is String) this.duration = json["duration"];
    if (json["charges"] is String) this.charges = json["charges"];
    if (json["frag"] is String) this.frag = json["frag"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
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
    return data;
  }
}

class PortfolioStat {
  double invested;
  double rented;
  double owned;

  PortfolioStat({this.invested, this.rented, this.owned});

  PortfolioStat.fromJson(Map<String, dynamic> json) {
    if (json["invested"] is double) this.invested = json["invested"];
    if (json["rented"] is double) this.rented = json["rented"];
    if (json["owned"] is double) this.owned = json["owned"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["invested"] = this.invested;
    data["rented"] = this.rented;
    data["owned"] = this.owned;
    return data;
  }
}
