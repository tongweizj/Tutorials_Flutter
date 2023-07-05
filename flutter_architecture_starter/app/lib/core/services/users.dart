import 'dart:convert';

import 'package:app/core/constants/global.dart';
import 'package:app/core/constants/storage.dart';
import 'package:app/core/models/jwt_login.dart';
import 'package:app/core/models/store_data.dart';
import 'package:app/core/models/token.dart';
import 'package:app/core/models/user.dart';
import 'package:app/core/utils/http.dart';
import 'package:app/core/utils/storage.dart';
import 'package:app/core/utils/user.dart';

import 'credential.dart';
export 'credential.dart';

/// 用户
class UsersAPI {
  /// 功能1: 登录
  static Future<Map> login({String username, String passwd}) async {
    /// 整理后的api返回数据
    Map<String, dynamic> apiResponseEdit;

    /// 返回数据
    var userData = {"code": 0, "userData": {}, "message": ''};

    /// 1. 生成，用户登录请求
    UserLoginRequestEntity params =
        makeUserLoginRequest(username.toLowerCase(), passwd);

    /// 2. 生成用户登认证信息

    /// type 说明
    /// 0 = 初始，
    /// 1 = 成功，
    /// -1 = 网络错误
    /// -2 = 用户名、密码错误

    try {
      var getApiResponse = await HttpUtil().post('login', params: params);
      // print(apiResponse);
      apiResponseEdit = json.decode(getApiResponse);
      if (apiResponseEdit['error'] == null) {
        userData['code'] = 1;
        userData['userData'] =
            checkUserProfile(apiResponseEdit, username: username);

        /// 暂时注释
        saveProfile(LoginRespModel.fromJson(userData['userData']));

        ///  保存用户认证数据
        StoreData.saveUserCredential(params.credential);
        Global.userToken = TokenRespModel.fromJson(apiResponseEdit);

        /// 读取用户的短名
        UserUtils.makeUserShortName();

        /// 读取用户历史测温记录
        /// 使用登录邮箱去检查是否在本地存有这个数据
        /// 测温记录，会在用户登出的时候存起来
        // var _eventListJSON = StorageUtil().getLogoutUserData2(username);
        // if (_eventListJSON != null) {
        //   EventsUtils.saveEventList(
        //       EventListResponseEntity.fromJson(_eventListJSON));
        // }
      } else {
        userData['code'] = -2;
        userData['message'] = 'Please check your username or password!';
      }
    } catch (e) {
      userData['code'] = -1;
      userData['message'] = 'Please check your network!';
    }

    /// 3. 根据API返回数据，保存用户信息
    return userData;
  }

  // /// 功能2: 更新profile
  // static Future<Map> updateProfile() async {
  //   /// 1）创建请求参数
  //   ProfileRequestEntity params = makeUserProfileRequest();

  //   /// 2）发起请求
  //   /// type 说明
  //   /// 0 = 初始，
  //   /// 1 = 成功，
  //   /// -1 = 网络错误
  //   /// -2 = 用户名、密码错误

  //   /// 返回数据
  //   var response = {"code": 0, "message": ''};
  //   print('apiResponse start');

  //   var apiResponse = await HttpUtil().post(
  //     'user',
  //     params: params,
  //   );
  //   print('apiResponse end');
  //   if (apiResponse == 'Success') {
  //     response['code'] = 1;
  //     response['message'] = 'Profile update success!';
  //     StorageUtil().setJSON(STORAGE_USER_PROFILE_KEY, Global.profile);

  //     ///Global.saveUserCredential(TempDataUtil.makeUserCredential(Global.profile.email,newPasswd));
  //   } else {
  //     response['code'] = -1;
  //     response['message'] =
  //         'Change profile failure, Please retry wait a moment!';
  //   }
  //   return response;
  // }

  // /// 功能3: 更改密码
  // static Future<Map> changePasswd({
  //   String newPasswd,
  // }) async {
  //   ChangePasswordRequestEntity params =
  //       makeUserChangePasswordRequest(newPasswd);

  //   var response = {"code": 0, "message": ''};
  //   var apiResponse;
  //   try {
  //     apiResponse = await HttpUtil().post(
  //       'user',
  //       params: params,
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //   if (apiResponse == 'Success') {
  //     response['code'] = 1;
  //     response['message'] = apiResponse;
  //     StoreData.saveUserCredential(Credential.generate(
  //         Global.profile.username.toLowerCase(), newPasswd));
  //   } else {
  //     response['code'] = -1;
  //     response['message'] =
  //         'Change password failure, Please retry wait a moment!';
  //   }
  //   return response;
  // }

  // /// 功能4: 更改密码
  // static Future<Map> forgetPasswd({
  //   String email,
  // }) async {
  //   Map params = {"action": "reset", 'username': email};

  //   var response = {"code": 0, "message": ''};
  //   var apiResponse;
  //   try {
  //     apiResponse = await HttpUtil().post(
  //       'send_reset_link',
  //       params: params,
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //   if (apiResponse == 'Success') {
  //     response['code'] = 1;
  //     response['message'] = 'Reset password success, Please check your email!';
  //   } else {
  //     response['code'] = -1;
  //     response['message'] =
  //         'Reset password failure, Please retry wait a moment!';
  //   }
  //   return response;
  // }

  // /// 获取用户profile补充信息
  // /// 头像、suname、mobile
  // static Future putUserProfile() async {
  //   var apiResp; // api返回的原始数据
  //   Map<String, dynamic> apiRespMap; // 整理后的api返回数据/// 整理后的api返回数据

  //   Map params = {
  //     "action": "list-user",
  //     "credential": Global.credential,
  //     "company": Global.profile.company[0],
  //     "username": Global.profile.username
  //   };
  //   apiResp = await HttpUtil().post('user', params: params);
  //   // print(apiResponse);
  //   apiRespMap = json.decode(apiResp);

  //   /// 异常情况处理
  //   if (apiRespMap['username'] != null) {
  //     Global.profile.avatar = apiRespMap['avatar'];
  //   }
  //   saveProfile(Global.profile);
  // }
  //////////////////////////////////////////
  /// API 辅助功能
  ///
  /// /////////////////////////////////////

  // 持久化：用户信息
  static Future<bool> saveProfile(LoginRespModel userResponse) {
    Global.profile = userResponse; // 暂时关掉
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }

  // 更新本地用户信息
  static saveProfileItem(String title, String newItem) async {
    if (title == "Given Name") {
      //TODO：修改接口，profile改成profile2
      Global.profile.givenName = newItem;
    } else if (title == "Display Name") {
      Global.profile.displayName = newItem;
    }
    // else if (title == "Birth Year") {
    //   profile2.birthYear = newItem;
    // }
    else if (title == "Company") {
      Global.profile.company = newItem;
    }
    // ProfileRequestEntity params = DataControl.makeUserProfileRequest();
    // Map res = await UserAPI.updateProfile(params: params);
    // print(res);
    // return res;
  }

  /// 构造请求：用户登录请求
  static makeUserLoginRequest(String username, String passwd) {
    String credentialHex = Credential.generate(username, passwd);
    UserLoginRequestEntity params =
        UserLoginRequestEntity(credential: credentialHex);
    return params;
  }

  // /// 构造请求：用户修改profile请求
  // /// TODO：修改接口，profile改成profile2
  // static makeUserProfileRequest() {
  //   UserInfo userInfo = UserInfo(
  //       username: Global.profile.username,
  //       displayName: Global.profile.displayName,
  //       givenName: Global.profile.givenName,
  //       avatar: Global.profile.avatar[0],
  //       mobile: ' ');
  //   ProfileRequestEntity params = ProfileRequestEntity(
  //       action: "edit",
  //       credential: Global.credential,
  //       company: Global.profile.company,
  //       userInfo: userInfo);
  //   return params;
  // }

  // /// 构造请求：用户修改密码请求
  // static makeUserChangePasswordRequest(String passwd) {
  //   ChangePasswordUserInfo userInfo = ChangePasswordUserInfo(
  //     username: Global.profile.username,
  //     oldPassword: Global.credential,
  //     newPassword:
  //         Credential.generate(Global.profile.username.toLowerCase(), passwd),
  //   );
  //   ChangePasswordRequestEntity params = ChangePasswordRequestEntity(
  //       action: "edit-password",
  //       accessToken: Global.userToken.accessToken,
  //       company: Global.profile.company,
  //       userInfo: userInfo);
  //   return params;
  // }

  /// 检查用户登录信息是否完整
  static checkUserProfile(
    Map userProfile, {
    String username = 'email@email.com',
  }) {
    if (userProfile['email'] == null) {
      userProfile['email'] = username;
    }

    if (userProfile['givenName'] == null) {
      userProfile['familyName'] = 'givename';
    } else {
      userProfile['familyName'] = userProfile['givenName'];
    }
    if (userProfile['displayName'] == null) {
      userProfile['displayName'] = userProfile['email'];
    }
    if (userProfile['company'] == null) {
      userProfile['company'] = 'mobile';
    }
    if (userProfile['company'] is List) {
      userProfile['company'] = userProfile["company"][0];
      // userData['uuid'] = DateTime.now().millisecondsSinceEpoch.toString();
    }
    if (userProfile['company'] is Map) {
      userProfile['company'] = userProfile["company"]["name"];
      // userData['uuid'] = DateTime.now().millisecondsSinceEpoch.toString();
    }
    if (userProfile['uuid'] == null) {
      userProfile['uuid'] = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return userProfile;
  }
}
