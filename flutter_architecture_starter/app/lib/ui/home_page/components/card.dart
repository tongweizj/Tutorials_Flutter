import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCard(BuildContext context, String featureName, String featureIcon,
    String router) {
  return GestureDetector(
    onTap: () => {
      /// 跳转首页
      Navigator.pushNamed(
        context,
        router,
      )
    },
    child: Container(
      width: 125.w,
      height: 0.4.sw,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade50)),
      padding: const EdgeInsets.all(3.0),
      child: Container(
          // color: Colors.deepPurpleAccent,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.h),
              Image.asset(
                "assets/icon/${featureIcon}",
                width: 48.w,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 5.h),
              Text(featureName)
            ],
          )),
    ),
  );
}
