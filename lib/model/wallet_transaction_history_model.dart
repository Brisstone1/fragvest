class WalletTransationHistoryModel {
  bool success;
  List<HistoryData> history;
  Page page;

  WalletTransationHistoryModel({this.success, this.history, this.page});

  WalletTransationHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["data"] is List)
      this.history = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => HistoryData.fromJson(e)).toList();
    if (json["page"] is Map)
      this.page = json["page"] == null ? null : Page.fromJson(json["page"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.history != null)
      data["data"] = this.history.map((e) => e.toJson()).toList();
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

class HistoryData {
  int id;
  String customerId;
  String amount;
  String type;
  String isRefund;
  dynamic reason;
  String duplicateCheck;
  String updatedAt;
  String date;
  String status;
  String narration;

  HistoryData(
      {this.id,
      this.customerId,
      this.amount,
      this.type,
      this.isRefund,
      this.reason,
      this.duplicateCheck,
      this.updatedAt,
      this.date,
      this.status, this.narration});

  HistoryData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["customer_id"] is String) this.customerId = json["customer_id"];
    if (json["amount"] is String) this.amount = json["amount"];
    if (json["type"] is String) this.type = json["type"];
    if (json["is_refund"] is String) this.isRefund = json["is_refund"];
    this.reason = json["reason"];
    if (json["duplicate_check"] is String)
      this.duplicateCheck = json["duplicate_check"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["date"] is String) this.date = json["date"];
    if (json["status"] is String) this.status = json["status"];
    if (json["narration"] is String) this.narration = json["narration"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["customer_id"] = this.customerId;
    data["amount"] = this.amount;
    data["type"] = this.type;
    data["is_refund"] = this.isRefund;
    data["reason"] = this.reason;
    data["duplicate_check"] = this.duplicateCheck;
    data["updated_at"] = this.updatedAt;
    data["date"] = this.date;
    data["status"] = this.status;
    data["narration"] = this.narration;


    return data;
  }
}
