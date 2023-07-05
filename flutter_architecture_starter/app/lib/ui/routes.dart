import 'package:app/ui/splash_page/index.dart';

import 'home_page/index.dart';
import 'login_page/index.dart';
import 'mqtt_page/index.dart';

/// 静态路由
var staticRoutes = {
  "/splash": (context) => SplashPage(), // 启动页
  "/login": (context) => LoginPage(), // 登录
  "/home": (context) => HomePage(), // APP 首页
  "/mqtt": (context) => MQTTPage(), // MQTT 业务
};
