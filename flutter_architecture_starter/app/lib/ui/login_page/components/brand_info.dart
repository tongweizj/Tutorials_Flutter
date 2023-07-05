// Brand Information block
import 'package:app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBrandInfo() {
  return Container(
    margin: EdgeInsets.only(top: 44.0.h), // 顶部系统栏 44px
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _logoBig(),
        _appSlogan(),
      ],
    ),
  );
}

// logo
Widget _logoBig() {
  return Container(
      width: 280.w,
      height: 85.h,
      child: Image.asset(
        "assets/icon/logo.png",
        fit: BoxFit.none,
      ));
}

/// App Slogan
Widget _appSlogan() {
  return Container(
    width: 300.w,
    height: 30.h,
    margin: EdgeInsets.only(top: 20.h),
    child: Text(
      "See more.  Know More.  Do More.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Santral",
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.3,
      ),
    ),
  );
}
