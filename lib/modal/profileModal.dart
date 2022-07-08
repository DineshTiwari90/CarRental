// To parse this JSON data, do
//
//     final profileModal = profileModalFromJson(jsonString);

import 'dart:convert';

ProfileModal profileModalFromJson(String str) =>
    ProfileModal.fromJson(json.decode(str));

String profileModalToJson(ProfileModal data) => json.encode(data.toJson());

class ProfileModal {
  ProfileModal({
    this.name,
    this.surName,
    this.email,
    this.phoneNumber,
    this.dob,
    this.country,
    this.profileImage,
    this.emailVerified,
    this.phoneVerified,
    this.loginWay,
    this.otpVerified,
    this.licenseName,
    this.licenseSurName,
    this.licenseNo,
    this.expiryDate,
    this.licenseCountry,
    this.licenseCategory,
    this.licensePhoto,
    this.passportName,
    this.passportSurName,
    this.passportCountry,
    this.passportNo,
    this.passportExpiryDate,
    this.passportPhoto,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? name;
  String? surName;
  String? email;
  String? phoneNumber;
  String? dob;
  String? country;
  List<dynamic>? profileImage;
  bool? emailVerified;
  bool? phoneVerified;
  String? loginWay;
  bool? otpVerified;
  String? licenseName;
  String? licenseSurName;
  String? licenseNo;
  String? expiryDate;
  String? licenseCountry;
  String? licenseCategory;
  List<dynamic>? licensePhoto;
  String? passportName;
  String? passportSurName;
  String? passportCountry;
  String? passportNo;
  String? passportExpiryDate;
  List<dynamic>? passportPhoto;
  bool? isActive;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory ProfileModal.fromJson(Map<String, dynamic> json) => ProfileModal(
        name: json["name"] ?? '',
        surName: json["sur_name"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"] ?? "",
        dob: json["dob"] ?? '',
        country: json["country"] ?? '',
        profileImage: List<dynamic>.from(json["profile_image"].map((x) => x)),
        emailVerified: json["email_verified"] ?? '',
        phoneVerified: json["phone_verified"] ?? "",
        loginWay: json["login_way"] ?? '',
        otpVerified: json["otp_verified"] ?? '',
        licenseName: json["license_name"] ?? "",
        licenseSurName: json["license_sur_name"] ?? "",
        licenseNo: json["license_no"] ?? "",
        expiryDate: json["expiry_date"] ?? "",
        licenseCountry: json["license_country"] ?? "",
        licenseCategory: json["license_category"] ?? '',
        licensePhoto: List<dynamic>.from(json["license_photo"].map((x) => x)),
        passportName: json["passport_name"] ?? "",
        passportSurName: json["passport_sur_name"] ?? "",
        passportCountry: json["passport_country"] ?? "",
        passportNo: json["passport_no"] ?? "",
        passportExpiryDate: json["passport_expiry_date"] ?? "",
        passportPhoto: List<dynamic>.from(json["passport_photo"].map((x) => x)),
        isActive: json["isActive"] ?? "",
        id: json["_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sur_name": surName,
        "email": email,
        "phone_number": phoneNumber,
        "dob": dob,
        "country": country,
        "profile_image": List<dynamic>.from(profileImage!.map((x) => x)),
        "email_verified": emailVerified,
        "phone_verified": phoneVerified,
        "login_way": loginWay,
        "otp_verified": otpVerified,
        "license_name": licenseName,
        "license_sur_name": licenseSurName,
        "license_no": licenseNo,
        "expiry_date": expiryDate,
        "license_country": licenseCountry,
        "license_category": licenseCategory,
        "license_photo": List<dynamic>.from(licensePhoto!.map((x) => x)),
        "passport_name": passportName,
        "passport_sur_name": passportSurName,
        "passport_country": passportCountry,
        "passport_no": passportNo,
        "passport_expiry_date": passportExpiryDate,
        "passport_photo": List<dynamic>.from(passportPhoto!.map((x) => x)),
        "isActive": isActive,
        "_id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
