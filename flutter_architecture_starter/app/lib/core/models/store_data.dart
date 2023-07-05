import 'package:app/core/constants/global.dart';
import 'package:app/core/constants/storage.dart';
import 'package:app/core/utils/storage.dart';

class StoreData {
  // 持久化 用户信息
  // 搬迁 lib/common/services/users/saveProfile
  // static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
  //   Global.profile = userResponse;
  //   return StorageUtil()
  //       .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  // }

  // 持久化 用户登录认证信息
  static Future<bool> saveUserCredential(String credential) {
    Global.credential = credential;
    return StorageUtil().setJSON(STORAGE_USER_CREDENTIAL_KEY, credential);
  }
}
