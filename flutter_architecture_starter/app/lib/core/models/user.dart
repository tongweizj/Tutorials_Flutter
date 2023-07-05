// 登录-请求
class UserLoginRequestEntity {
  UserLoginRequestEntity({
    this.credential,
  });

  String credential;

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        credential: json["credential"],
      );

  Map<String, dynamic> toJson() => {
        "credential": credential,
      };
}

// 登录-返回
class UserLoginResponseEntity {
  UserLoginResponseEntity({
    this.username,
    this.company,
    this.displayName,
    this.givenName,
    this.uuid,
    this.email,
  });

  String username;
  String company;
  String uuid;
  String displayName;
  String givenName;
  String email;

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        username: json["username"],
        company: json["company"] == null ? null : json["company"],
        displayName: json["displayName"],
        givenName: json["givenName"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "company": company == null ? null : company,
        "displayName": displayName,
        "givenName": givenName,
        "uuid": uuid == null ? null : uuid,
        "email": email == null ? null : email,
      };
}
