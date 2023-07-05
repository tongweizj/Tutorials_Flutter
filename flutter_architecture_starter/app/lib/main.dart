import 'dart:io';

import 'package:app/provider_setup.dart';
import 'package:app/ui/routes.dart';
import 'package:app/ui/splash_page/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 667),
        builder: () => MaterialApp(
              title: 'Luci',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                //要支持下面这个需要使用第一种初始化方式
                textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
              ),
              home: SplashPage(),
              routes: staticRoutes,
              debugShowCheckedModeBanner: false,
            ));
  }
}
