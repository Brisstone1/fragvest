
class FeeModel {
  bool success;
  List<Data> data;

  FeeModel({this.success, this.data});

  FeeModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(data != null) {
      _data["data"] = data.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String transactionFee;
  String transactionFeeCap;
  String agentTourFee;
  String brokerCharge;

  Data({this.transactionFee, this.transactionFeeCap, this.agentTourFee, this.brokerCharge});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["transaction_fee"] is String) {
      transactionFee = json["transaction_fee"];
    }
    if(json["transaction_fee_cap"] is String) {
      transactionFeeCap = json["transaction_fee_cap"];
    }
    if(json["agent_tour_fee"] is String) {
      agentTourFee = json["agent_tour_fee"];
    }
    if(json["broker_charge"] is String) {
      brokerCharge = json["broker_charge"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["transaction_fee"] = transactionFee;
    _data["transaction_fee_cap"] = transactionFeeCap;
    _data["agent_tour_fee"] = agentTourFee;
    _data["broker_charge"] = brokerCharge;
    return _data;
  }
}