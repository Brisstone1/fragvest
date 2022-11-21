import '../repository/repo_Validatary.dart';

class PaystackAccessToken extends RepoValidator {
  bool success;
  AccessCode accessCode;

  PaystackAccessToken({this.success, this.accessCode});

  PaystackAccessToken.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["access_code"] is Map)
      this.accessCode = json["access_code"] == null
          ? null
          : AccessCode.fromJson(json["access_code"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.accessCode != null) data["access_code"] = this.accessCode.toJson();
    return data;
  }
}

class AccessCode {
  String authorizationUrl;
  String accessCode;
  String reference;

  AccessCode({this.authorizationUrl, this.accessCode, this.reference});

  AccessCode.fromJson(Map<String, dynamic> json) {
    if (json["authorization_url"] is String)
      this.authorizationUrl = json["authorization_url"];
    if (json["access_code"] is String) this.accessCode = json["access_code"];
    if (json["reference"] is String) this.reference = json["reference"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["authorization_url"] = this.authorizationUrl;
    data["access_code"] = this.accessCode;
    data["reference"] = this.reference;
    return data;
  }
}
