class GetAllTicketsModel {
  bool success;
  Data data;

  GetAllTicketsModel({this.success, this.data});

  GetAllTicketsModel.fromJson(Map<String, dynamic> json) {
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
  List<Tickets> tickets;

  Data({this.tickets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["tickets"] is List)
      this.tickets = json["tickets"] == null
          ? null
          : (json["tickets"] as List).map((e) => Tickets.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tickets != null)
      data["tickets"] = this.tickets.map((e) => e.toJson()).toList();
    return data;
  }
}

class Tickets {
  int id;
  String userId;
  String ticketId;
  String subject;
  String status;
  String date;

  Tickets(
      {this.id,
      this.userId,
      this.ticketId,
      this.subject,
      this.status,
      this.date});

  Tickets.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["user_id"] is String) this.userId = json["user_id"];
    if (json["ticket_id"] is String) this.ticketId = json["ticket_id"];
    if (json["subject"] is String) this.subject = json["subject"];
    if (json["status"] is String) this.status = json["status"];
    if (json["date"] is String) this.date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["ticket_id"] = this.ticketId;
    data["subject"] = this.subject;
    data["status"] = this.status;
    data["date"] = this.date;
    return data;
  }
}
