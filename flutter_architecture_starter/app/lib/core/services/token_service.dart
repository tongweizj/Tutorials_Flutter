import 'dart:convert';

import 'package:app/core/constants/global.dart';
import 'package:app/core/models/token.dart';
import 'package:app/core/utils/date.dart';
import 'package:app/core/utils/http.dart';

class TokenAPI {
  /// 功能1: 从本地获取用户Token
  /// TODO： 当accessToken 过期后，要把过期的删掉
  static Future<String> getUserAccessToken(
      {String username: '', String passwd: ''}) async {
    Global.userName = username;
    Global.userPassword = passwd;
    // TODO: 当没有
    // if (Global.userToken == null) {
    //   return await getUserToken(); // 1)更新用户token 后返回 token
    // }
    // print(duTimeMillis(0) - Global.userGetTokenTimestamp);
    if (duTimeMillis(0) - Global.userGetTokenTimestamp > 2 * 60 * 1000) {
      return await updateUserToken();
    } else {
      return Global.userToken.accessToken;
    }
  }

  /// 功能2: 从服务端取用户Token
  // static Future getUserToken() async {
  //   var apiResp; // api返回的原始数据
  //   Map<String, dynamic> apiRespMap; // 整理后的api返回数据

  //   /// 1. 生成 Request params
  //   TokenRequestModel params = makeUserTokenRequest(
  //       username: Global.userName, passwd: Global.userPassword);

  //   /// 2. 获取 api 接口返回数据
  //   apiResp = await HttpUtil().post('user', params: params);

  //   /// 3. 检查返回数据是否正常
  //   apiRespMap = json.decode(apiResp);
  //   if (apiRespMap["accessToken"] != null) {
  //     /// 4. 保存全局变量
  //     Global.userToken = TokenRespModel.fromJson(json.decode(apiResp));
  //     Global.userGetTokenTimestamp = duTimeMillis(0);
  //     return Global.userToken.accessToken;
  //   }
  // }

  /// 构造请求：用户获取Token请求
  // static makeUserTokenRequest({String username: '', String passwd: ''}) {
  //   TokenRequestModel params;
  //   if (username == '') {
  //     params = TokenRequestModel(
  //         action: "generateToken",
  //         password: Global.credential,
  //         username: Global.profile.username);
  //   } else {
  //     params = TokenRequestModel(
  //         action: "generateToken",
  //         password: Credential.generate(username, passwd),
  //         username: username);
  //   }
  //   return params;
  // }

  /// TODO： 功能2: update用户Token
  static Future updateUserToken() async {
    var apiResp; // api返回的原始数据
    Map<String, dynamic> apiRespMap; // 整理后的api返回数据

    /// 1. 生成 Request params
    UpdateTokenRequest params = updateUserTokenRequest();

    /// 2. 获取 api 接口返回数据
    apiResp = await HttpUtil().post('user', params: params);

    /// 3. 检查返回数据是否正常
    // apiRespMap = json.decode(apiResp);
    if (apiResp != null) {
      /// 4. 保存全局变量
      Global.userToken.accessToken = apiResp;
      Global.userGetTokenTimestamp = duTimeMillis(0);
    }
    print(Global.userToken.accessToken);
  }

  /// 构造请求：用户获取Token请求
  static updateUserTokenRequest() {
    UpdateTokenRequest params;
    params = UpdateTokenRequest(
        action: "updateToken",
        refreshToken: Global.userToken.refreshToken,
        username: Global.profile.username);

    return params;
  }
}
