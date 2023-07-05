import 'dart:convert';

class LoginRequestModel {
  LoginRequestModel({
    this.credential,
    this.username,
  });

  String credential;
  String username;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        credential: json["credential"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "credential": credential,
        "username": username,
      };
}

class LoginRespModel {
  LoginRespModel({
    this.username,
    this.company,
    this.avatar,
    this.sites,
    this.services,
    this.displayName,
    this.givenName,
    this.timezone,
    this.accessToken,
    this.refreshToken,
  });

  String username;
  String company;
  String avatar;
  List<Site> sites;
  List<String> services;
  String displayName;
  String givenName;
  String timezone;
  String accessToken;
  String refreshToken;

  factory LoginRespModel.fromJson(Map<String, dynamic> json) => LoginRespModel(
        username: json["username"],
        company: json["company"],
        avatar: json["avatar"],
        sites: List<Site>.from(json["sites"].map((x) => Site.fromJson(x))),
        services: List<String>.from(json["services"].map((x) => x)),
        displayName: json["displayName"],
        givenName: json["givenName"],
        timezone: json["timezone"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "company": company,
        "avatar": avatar,
        "sites": List<dynamic>.from(sites.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x)),
        "displayName": displayName,
        "givenName": givenName,
        "timezone": timezone,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class Company {
  Company({
    this.name,
    this.uuid,
  });

  String name;
  String uuid;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
      };
}

class Site {
  Site({
    this.uuid,
    this.name,
    this.address,
    this.timezone,
    this.labels,
    this.longitude,
    this.latitude,
    this.creation,
    this.active,
    this.users,
  });

  String uuid;
  String name;
  String address;
  String timezone;
  List<String> labels;
  String longitude;
  String latitude;
  int creation;
  bool active;
  List<dynamic> users;

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        uuid: json["uuid"],
        name: json["name"],
        address: json["address"],
        timezone: json["timezone"],
        labels: List<String>.from(json["labels"].map((x) => x)),
        longitude: json["longitude"],
        latitude: json["latitude"],
        creation: json["creation"],
        active: json["active"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "address": address,
        "timezone": timezone,
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "longitude": longitude,
        "latitude": latitude,
        "creation": creation,
        "active": active,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}
