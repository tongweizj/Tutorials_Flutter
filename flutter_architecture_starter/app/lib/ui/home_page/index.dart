import 'package:app/ui/widgets/basic_page.dart';
import 'package:app/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/appbar.dart';
import 'components/card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildBasicPage(
      context,
      pageTitle: 'Home',
      pageBody: Container(
          width: 375.w,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 0.h),
              Row(
                children: [
                  buildCard(context, 'mqtt', 'mqtt.png', '/mqtt'),
                  buildCard(context, 'update', 'mqtt.png', '/home'),
                  buildCard(context, 'chart', 'mqtt.png', '/home'),
                ],
              ),
              SizedBox(height: 0.h),
              Row(
                children: [
                  buildCard(context, 'ERCODE', 'mqtt.png', '/home'),
                  buildCard(context, 'mqtt', 'mqtt.png', '/home'),
                  // buildCard(context, 'mqtt', 'mqtt.png', '/home'),
                ],
              ),
            ],
          )),
    );
  }
}
