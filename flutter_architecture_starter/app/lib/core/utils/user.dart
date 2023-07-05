import 'package:app/core/constants/global.dart';

class UserUtils {
  /// 构造用户头像信息
  static makeUserShortName() {
    // print(Global.profile.displayName);
    Global.shortName =
        (Global.profile.displayName[0] + Global.profile.givenName[0])
            .toUpperCase();
    return Global.shortName;
  }
}
