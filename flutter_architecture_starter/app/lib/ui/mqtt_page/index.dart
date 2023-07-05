import 'package:app/ui/widgets/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MQTTPage extends StatefulWidget {
  @override
  _MQTTPageState createState() => _MQTTPageState();
}

class _MQTTPageState extends State<MQTTPage> {
  @override
  Widget build(BuildContext context) {
    return buildBasicPage(context,
        pageTitle: 'MQTT', //buildAppBar(context, title: 'Home'),
        pageBody: Container(
          width: 375.w,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 0.h),
            ],
          ),
        ));
  }
}
