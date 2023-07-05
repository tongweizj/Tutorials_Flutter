import 'dart:io';

import 'package:app/core/models/jwt_login.dart';
import 'package:app/core/models/token.dart';
import 'package:app/core/utils/http.dart';
import 'package:app/core/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 全局配置
class Global {
  /// 用户配置
  /// 全局变量，在任何位置，只要导入global文件，就可以调用这个变量 profile
  // static UserLoginResponseEntity profile = UserLoginResponseEntity(
  //   accessToken: null,
  // );
  static LoginRespModel profile = LoginRespModel();

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// login页是否显示返回按钮
  static bool isShowleadingIcon = true;

  /// userCredential
  static TokenRespModel userToken;
  static int userGetTokenTimestamp;
  // 用户登录认证字符串
  static String credential = '';
  static String toastMsg = ''; //弹出泡泡的文案
  static String userName = '';
  static String userPassword = '';

  /// 用户是否登录
  /// false = 没有登录
  /// true = 登录
  static bool isOfflineLogin = false;

  /// 用户是否登录
  /// false = 没有登录
  /// true = 登录
  static Map device = {};

  /// 是否新用户
  /// 新用户，注册后直接登录
  /// 没有使用密码登录，无法做更新用户信息
  /// 等和服务器做交互操作
  ///
  static bool isNewUser = false;

  /// 升级提醒：选择下一次提醒的时间戳
  static int upgradeRemindLate = 0;

  // 用户firebaseMessagingToken
  static String firebaseMessagingToken = '';
  // 用户头像中的姓名第一个字母
  static String shortName = '';

  /* Senosr*/
  static Map model = {};

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    await StorageUtil.init();
    HttpUtil();

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
