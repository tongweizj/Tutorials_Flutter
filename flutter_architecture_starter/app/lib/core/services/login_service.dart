import 'dart:convert';

import 'package:app/core/constants/global.dart';
import 'package:app/core/constants/storage.dart';
import 'package:app/core/models/jwt_login.dart';
import 'package:app/core/models/token.dart';
import 'package:app/core/services/credential.dart';
import 'package:app/core/utils/http.dart';
import 'package:app/core/utils/storage.dart';

class LoginAPI {
  /// 构造请求：用户登录请求
  static makeUserLoginRequest(String username, String passwd) {
    LoginRequestModel params;
    if (Global.credential == "" || Global.credential == null) {
      Global.credential = Credential.generate(username, passwd);
    }
    params = LoginRequestModel(
      username: username,
      credential: Global.credential,
    );
    return params;
  }

  /// 功能1: 登录
  Future<bool> jwtLogin({String username, String passwd}) async {
    var apiResp; // api返回数据
    // var tokenResp;

    /// 1. 获取用户token
    // try {
    //   tokenResp =
    //       await TokenAPI.getUserAccessToken(username: username, passwd: passwd);
    //   print(tokenResp);
    // } catch (e) {
    //   print(e);
    //   return false;
    // }

    /// 返回数据
    // var userData = {"code": 0, "userData": {}, "message": ''};

    /// 2. 生成，用户登录请求
    LoginRequestModel params =
        makeUserLoginRequest(username.toLowerCase(), passwd);

    /// 3. 获取 api 接口返回数据
    try {
      apiResp = await HttpUtil().post('login', params: params);
      // print(apiResponse);
      Map apiRespMap = json.decode(apiResp);
      Global.userToken = TokenRespModel.fromJson(apiRespMap);

      /// 异常情况处理
      /// 1） 用户名密码错误
      if (apiRespMap['error'] != null) {
        Global.toastMsg = 'Please check your user name and password!';
        return false;
      }

      /// 登陆正常情况处理
      if (apiRespMap['username'] != null) {
        /// 保存用户profile
        saveProfile(LoginRespModel.fromJson(apiRespMap));

        ///  保存用户认证数据
        // saveUserCredential(params.credential);
        /// 创建用户的短名
        makeUserShortName();
        return true;
      }
    } catch (e) {
      Global.toastMsg = 'Please check your network!';
      return false;
    }
  }

  // 持久化：用户信息
  static Future<bool> saveProfile(LoginRespModel userResponse) {
    Global.profile = userResponse; // 暂时关掉
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }

  // 持久化 用户登录认证信息
  // static Future<bool> saveUserCredential(String credential) {
  //   Global.userCredential = credential;
  //   return StorageUtil().setJSON(STORAGE_USER_CREDENTIAL_KEY, credential);
  // }

  // /// 构造用户头像信息
  static makeUserShortName() {
    // print(Global.profile.displayName);
    Global.shortName =
        (Global.profile.displayName[0] + Global.profile.givenName[0])
            .toUpperCase();
    return Global.shortName;
  }
}
