class NotificationModel {
  bool success;
  Data data;

  NotificationModel({this.success, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<dynamic> today;
  List<Others> others;

  Data({this.today, this.others});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["today"] is List) this.today = json["today"] ?? [];
    if (json["others"] is List)
      this.others = json["others"] == null
          ? null
          : (json["others"] as List).map((e) => Others.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) data["today"] = this.today;
    if (this.others != null)
      data["others"] = this.others.map((e) => e.toJson()).toList();
    return data;
  }
}

class Others {
  int id;
  String title;
  String body;
  String isSeen;
  String date;

  Others({this.id, this.title, this.body, this.isSeen, this.date});

  Others.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["title"] is String) this.title = json["title"];
    if (json["body"] is String) this.body = json["body"];
    if (json["is_seen"] is String) this.isSeen = json["is_seen"];
    if (json["date"] is String) this.date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["body"] = this.body;
    data["is_seen"] = this.isSeen;
    data["date"] = this.date;
    return data;
  }
}
