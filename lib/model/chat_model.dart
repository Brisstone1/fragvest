class ChatModel {
  bool success;
  Data data;

  ChatModel({this.success, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
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
  String ticketId;
  String subject;
  String status;
  Agent agent;
  List<Chats> chats;

  Data({this.ticketId, this.subject, this.status, this.agent, this.chats});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["ticket_id"] is String) this.ticketId = json["ticket_id"];
    if (json["subject"] is String) this.subject = json["subject"];
    if (json["status"] is String) this.status = json["status"];
    if (json["agent"] is Map)
      this.agent = json["agent"] == null ? null : Agent.fromJson(json["agent"]);
    if (json["chats"] is List)
      this.chats = json["chats"] == null
          ? null
          : (json["chats"] as List).map((e) => Chats.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ticket_id"] = this.ticketId;
    data["subject"] = this.subject;
    data["status"] = this.status;
    if (this.agent != null) data["agent"] = this.agent.toJson();
    if (this.chats != null)
      data["chats"] = this.chats.map((e) => e.toJson()).toList();
    return data;
  }
}

class Chats {
  int id;
  String description;
  String isSeen;
  String sentBy;
  String date;

  Chats({this.id, this.description, this.isSeen, this.sentBy, this.date});

  Chats.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["description"] is String) this.description = json["description"];
    if (json["is_seen"] is String) this.isSeen = json["is_seen"];
    if (json["sent_by"] is String) this.sentBy = json["sent_by"];
    if (json["date"] is String) this.date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["description"] = this.description;
    data["is_seen"] = this.isSeen;
    data["sent_by"] = this.sentBy;
    data["date"] = this.date;
    return data;
  }
}

class Agent {
  int id;
  String firstName;
  String lastName;
  String profileImg;

  Agent({this.id, this.firstName, this.lastName, this.profileImg});

  Agent.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["profile_img"] = this.profileImg;
    return data;
  }
}
