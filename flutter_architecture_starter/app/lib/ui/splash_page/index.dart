import 'dart:async';
import 'package:app/ui/index_page/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/bg.dart';
import 'components/brand.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  /// 启动页配置
  @override
  void initState() {
    super.initState();

    /// 三秒后跳转到引导页
    Timer(Duration(seconds: 3), () {
      /// 展示状态栏
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.bottom, SystemUiOverlay.top]);

      /// 自动跳转引导页
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => IndexPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            bg(),
            Positioned(child: brand()),
          ],
        ),
      ),
    );
  }
}
