import 'dart:convert';

class PrivacyModel {
  PrivacyModel({
    this.data,
  });

  Privacy? data;

  factory PrivacyModel.fromRawJson(String str) => PrivacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    data: Privacy.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Privacy {
  Privacy({
    this.id,
    this.name,
    this.price,
    this.percentage_price,
    this.icon
  });

  int? id;
  dynamic name;
  dynamic price;
  dynamic percentage_price;
  dynamic icon;



  factory Privacy.fromRawJson(String str) => Privacy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
      id: json["id"],
      name: json["name"],
      percentage_price: json["change_percent_1d"],
      icon: json['change_percent_1d']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "change_percent_1d":percentage_price,
    "change_percent_1d":icon
  };
}
