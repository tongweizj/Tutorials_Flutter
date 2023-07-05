import 'dart:convert';

TokenRequestModel tokenRequestModelFromJson(String str) =>
    TokenRequestModel.fromJson(json.decode(str));

String tokenRequestModelToJson(TokenRequestModel data) =>
    json.encode(data.toJson());

class TokenRequestModel {
  TokenRequestModel({
    this.action,
    this.password,
    this.username,
  });

  String action;
  String password;
  String username;

  factory TokenRequestModel.fromJson(Map<String, dynamic> json) =>
      TokenRequestModel(
        action: json["action"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "password": password,
        "username": username,
      };
}

TokenRespModel tokenRespModelFromJson(String str) =>
    TokenRespModel.fromJson(json.decode(str));

String tokenRespModelToJson(TokenRespModel data) => json.encode(data.toJson());

class TokenRespModel {
  TokenRespModel({
    this.accessToken,
    this.refreshToken,
  });

  String accessToken;
  String refreshToken;

  factory TokenRespModel.fromJson(Map<String, dynamic> json) => TokenRespModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

///////////////////////////////////////////////////

UpdateTokenRequest updateTokenRequestFromJson(String str) =>
    UpdateTokenRequest.fromJson(json.decode(str));

String updateTokenRequestToJson(UpdateTokenRequest data) =>
    json.encode(data.toJson());

class UpdateTokenRequest {
  UpdateTokenRequest({
    this.action,
    this.refreshToken,
    this.username,
  });

  String action;
  String refreshToken;
  String username;

  factory UpdateTokenRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTokenRequest(
        action: json["action"],
        refreshToken: json["refreshToken"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "refreshToken": refreshToken,
        "username": username,
      };
}
