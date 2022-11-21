
class InitiateFundModel {
  bool success;
  String ref;
  String amount;

  InitiateFundModel({this.success, this.ref, this.amount});

  InitiateFundModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["ref"] is String) {
      ref = json["ref"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["ref"] = ref;
    _data["amount"] = amount;
    return _data;
  }
}