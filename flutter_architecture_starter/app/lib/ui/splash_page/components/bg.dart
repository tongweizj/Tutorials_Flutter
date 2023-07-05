import 'package:app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bg() {
  return Positioned(
      child: Container(
          width: 375.w,
          height: 812.h,
          decoration: BoxDecoration(
            color: AppColors.splashBG,
          ),
          child: Image.asset(
            "assets/images/lanuch_bg.png",
            fit: BoxFit.fitWidth,
          )));
}
