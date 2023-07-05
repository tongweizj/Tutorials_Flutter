import 'package:app/core/constants/colors.dart';
import 'package:app/core/constants/radii.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:luci_thermal_personal_app/common/utils/utils.dart';
// import 'package:luci_thermal_personal_app/common/values/values.dart';

/// 输入框
Widget inputTextEdit({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String hintText,
  bool isPassword = false,
  double marginTop = 15,
}) {
  return Container(
    height: 50.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: Radii.k4pxRadius,
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColors.fontGrey,
        fontFamily: "SFProText",
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}

/// 用户名输入框
Widget inputEmailEdit({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String hintText,
  bool isPassword = false,
  double marginTop = 15,
}) {
  return Container(
    height: 50.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: Radii.k4pxRadius,
        border: Border.all(width: 1, color: AppColors.primaryBorder)),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.fontGrey),
        contentPadding: EdgeInsets.fromLTRB(18, 0, 0, 1),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "SFProText",
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}
