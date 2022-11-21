class WalletBalanceModel {
  bool success;
  Data data;

  WalletBalanceModel({this.success, this.data});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
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
  String walletBalance;

  Data({this.walletBalance});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["wallet_balance"] is String)
      this.walletBalance = json["wallet_balance"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["wallet_balance"] = this.walletBalance;
    return data;
  }
}
