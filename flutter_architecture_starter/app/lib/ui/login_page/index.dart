import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/app_bar.dart';
import 'components/brand_info.dart';
import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email的控制器
  final TextEditingController _emailController = TextEditingController();
  //密码的控制器
  final TextEditingController _passController = TextEditingController();
  // // fcm 实例
  // final fcnControl = FCMControl();
///////////////////////////
  /// TODO:
  /// 1）首次启用，获得推送权限
  ///
  /// 2）获得token、发送token

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   fcnControl.firebaseCloudMessagingListeners(context);
    // });
  }

  /// 页面组件容器
  Widget _buildPageStructure() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          imgHalfBackGround(opacity: 0.85), //设置背景色加透明度
          Positioned(
            child: Scaffold(
                backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
                appBar: transparentAppBar(
                  context: context,
                ),
                body: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    children: <Widget>[
                      buildBrandInfo(),
                      buildLoginForm(
                          context, _emailController, _passController),
                      // Spacer(),
                      // _buildPageFooter(),
                    ],
                  ),
                ))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageStructure();
  }

  /// 半屏高斯蒙层背景图
  Widget imgHalfBackGround({double opacity}) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/splash.png'),
        fit: BoxFit.cover,
      )),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 半透明层
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.white],
                    begin: Alignment(-1, -1),
                    end: Alignment(-1, 0.6)),
              ),
              height: 1.sh,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
                child: Opacity(
                  opacity: opacity, //透明读
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, //AppColors.primaryBackground,
                        border: Border.all(width: 1, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
