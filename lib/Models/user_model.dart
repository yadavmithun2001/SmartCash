import 'dart:convert';

class UserModel {
  UserModel({
    this.data,
  });

  User? data;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.displayname,
    this.mobilenumber,
    this.gallery,
    this.membership_start,
    this.membership_end,
    this.profile_active_status,
    this.created_at,
    this.updated_at,
    this.referral_code,
    this.email,
    this.location,
    this.person_joined_referral_link_total,
    this.joind_by_referralcode,
    this.password,
    this.currency,
    this.delivery_address,
    this.private_key,
    this.topup,
    this.wallet,
    this.hex_address
  });

  int? id;
  dynamic name;
  dynamic displayname;
  dynamic mobilenumber;
  dynamic gallery;
  dynamic membership_start;
  dynamic membership_end;
  dynamic profile_active_status;
  dynamic created_at;
  dynamic updated_at;
  dynamic referral_code;
  dynamic email;
  dynamic location;
  dynamic person_joined_referral_link_total;
  dynamic joind_by_referralcode;
  dynamic password;
  dynamic currency;
  dynamic delivery_address;
  dynamic private_key;
  dynamic topup;
  dynamic wallet;
  dynamic hex_address;


  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      displayname: json["displayname"],
      mobilenumber: json["mobilenumber"],
      gallery: json["gallery"],
      membership_start: json["membership_start"],
      membership_end: json["membership_end"],
      profile_active_status: json["profile_active_status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      referral_code: json["referral_code"],
      email: json["email"],
      location: json["location"],
      person_joined_referral_link_total: json["person_joined_referral_link_total"],
      joind_by_referralcode: json["joind_by_referralcode"],
      password: json["password"],
      currency: json["currency"],
      delivery_address : json["delivery_address"],
      private_key: json["private_key"],
      topup: json["topup"],
      wallet: json["wallet"],
      hex_address: json["hex_address"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "displayname":displayname,
    "mobilenumber": mobilenumber,
    "galley": gallery,
    "membership_start" : membership_start,
    "membership_end" : membership_end,
    "profile_active_status" : profile_active_status,
    "created_at" : created_at,
    "updated_at" : updated_at,
    "referral_code": referral_code,
    "email": email,
    "location":location,
    "person_joined_referral_link_total":person_joined_referral_link_total,
    "joind_by_referralcode": joind_by_referralcode,
    "password": password,
    "delivery_address":delivery_address,
    "private_key":private_key,
    "topup":topup,
    "wallet":wallet,
    "hex_address": hex_address
  };
}
