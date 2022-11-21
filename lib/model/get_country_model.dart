class GetCountryModel {
  bool success;
  List<Data> data;

  GetCountryModel({this.success, this.data});

  GetCountryModel.fromJson(Map<String, dynamic> json) {
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


class GetStateModel {
  bool success;
  List<Data> data;

  GetStateModel({this.success, this.data});

  GetStateModel.fromJson(Map<String, dynamic> json) {
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

class GetCityModel {
  bool success;
  List<Data> data;

  GetCityModel({this.success, this.data});

  GetCityModel.fromJson(Map<String, dynamic> json) {
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
  String iso;
  String name;
  String iso3;
  String phonecode;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.iso,
      this.name,
      this.iso3,
      this.phonecode,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["iso"] is String) this.iso = json["iso"];
    if (json["name"] is String) this.name = json["name"];
    if (json["iso3"] is String) this.iso3 = json["iso3"];
    if (json["phonecode"] is String) this.phonecode = json["phonecode"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["iso"] = this.iso;
    data["name"] = this.name;
    data["iso3"] = this.iso3;
    data["phonecode"] = this.phonecode;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
