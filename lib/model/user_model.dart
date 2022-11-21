class UserModel {
  bool success;
  Data data;

  UserModel({this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String status;
  String countryId;
  String logSession;
  String pin;
  String profileImg;
  int emailAlert;
  int smsAlert;
  String verificationStatus;
  String gender;
  String dateOfBirth;
  dynamic state;
  dynamic city;
  int completeRegistration;
  dynamic govtIssuedIdType;
  dynamic govtIssuedIdNumber;
  dynamic govtIssuedIdImageFv;
  dynamic govtIssuedIdImageBv;
  int idUploaded;
  int idVerified;
  String postalCode;
  String address;
  String verificationToken;
  String verificationTokenExpiration;
  dynamic referredBy;
  int verifiedBy;
  int suspendedBy;
  String walletBalance;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.status,
      this.countryId,
      this.logSession,
      this.pin,
      this.profileImg,
      this.emailAlert,
      this.smsAlert,
      this.verificationStatus,
      this.gender,
      this.dateOfBirth,
      this.state,
      this.city,
      this.completeRegistration,
      this.govtIssuedIdType,
      this.govtIssuedIdNumber,
      this.govtIssuedIdImageFv,
      this.govtIssuedIdImageBv,
      this.idUploaded,
      this.idVerified,
      this.postalCode,
      this.address,
      this.verificationToken,
      this.verificationTokenExpiration,
      this.referredBy,
      this.verifiedBy,
      this.suspendedBy,
      this.walletBalance});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["email"] is String) this.email = json["email"];
    if (json["phone"] is String) this.phone = json["phone"];
    if (json["status"] is String) this.status = json["status"];
    if (json["country_id"] is String) this.countryId = json["country_id"];
    if (json["log_session"] is String) this.logSession = json["log_session"];
    if (json["pin"] is String) this.pin = json["pin"];
    if (json["profile_img"] is String) this.profileImg = json["profile_img"];
    if (json["email_alert"] is int) this.emailAlert = json["email_alert"];
    if (json["sms_alert"] is int) this.smsAlert = json["sms_alert"];
    if (json["verification_status"] is String)
      this.verificationStatus = json["verification_status"];
    if (json["gender"] is String) this.gender = json["gender"];
    if (json["date_of_birth"] is String)
      this.dateOfBirth = json["date_of_birth"];
    this.state = json["state"];
    this.city = json["city"];
    if (json["complete_registration"] is int)
      this.completeRegistration = json["complete_registration"];
    this.govtIssuedIdType = json["govt_issued_id_type"];
    this.govtIssuedIdNumber = json["govt_issued_id_number"];
    this.govtIssuedIdImageFv = json["govt_issued_id_image_fv"];
    this.govtIssuedIdImageBv = json["govt_issued_id_image_bv"];
    if (json["id_uploaded"] is int) this.idUploaded = json["id_uploaded"];
    if (json["id_verified"] is int) this.idVerified = json["id_verified"];
    if (json["postal_code"] is String) this.postalCode = json["postal_code"];
    if (json["address"] is String) this.address = json["address"];
    if (json["verification_token"] is String)
      this.verificationToken = json["verification_token"];
    if (json["verification_token_expiration"] is String)
      this.verificationTokenExpiration = json["verification_token_expiration"];
    this.referredBy = json["referred_by"];
    if (json["verified_by"] is int) this.verifiedBy = json["verified_by"];
    if (json["suspended_by"] is int) this.suspendedBy = json["suspended_by"];
    if (json["wallet_balance"] is String)
      this.walletBalance = json["wallet_balance"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["status"] = this.status;
    data["country_id"] = this.countryId;
    data["log_session"] = this.logSession;
    data["pin"] = this.pin;
    data["profile_img"] = this.profileImg;
    data["email_alert"] = this.emailAlert;
    data["sms_alert"] = this.smsAlert;
    data["verification_status"] = this.verificationStatus;
    data["gender"] = this.gender;
    data["date_of_birth"] = this.dateOfBirth;
    data["state"] = this.state;
    data["city"] = this.city;
    data["complete_registration"] = this.completeRegistration;
    data["govt_issued_id_type"] = this.govtIssuedIdType;
    data["govt_issued_id_number"] = this.govtIssuedIdNumber;
    data["govt_issued_id_image_fv"] = this.govtIssuedIdImageFv;
    data["govt_issued_id_image_bv"] = this.govtIssuedIdImageBv;
    data["id_uploaded"] = this.idUploaded;
    data["id_verified"] = this.idVerified;
    data["postal_code"] = this.postalCode;
    data["address"] = this.address;
    data["verification_token"] = this.verificationToken;
    data["verification_token_expiration"] = this.verificationTokenExpiration;
    data["referred_by"] = this.referredBy;
    data["verified_by"] = this.verifiedBy;
    data["suspended_by"] = this.suspendedBy;
    data["wallet_balance"] = this.walletBalance;
    return data;
  }
}
