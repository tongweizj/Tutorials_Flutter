import 'package:app/core/constants/colors.dart';
import 'package:app/core/constants/radii.dart';
import 'package:app/core/utils/iconfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:luci_thermal_personal_app/common/utils/utils.dart';
// import 'package:luci_thermal_personal_app/common/values/values.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    this.fieldKey,
    this.hintText,
    this.isPassword = true,
    this.marginTop = 15,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  final Key fieldKey;
  final String hintText;
  final bool isPassword;
  final double marginTop;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      constraints: BoxConstraints(
        minWidth: 180,
        minHeight: 40,
      ),
      margin: EdgeInsets.only(top: widget.marginTop.h),
      decoration: BoxDecoration(
          color: AppColors.textFieldBG,
          borderRadius: Radii.k4pxRadius,
          border: Border.all(width: 1, color: AppColors.blockBackgroundColor)),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.blockBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(18, 12, 0, 2),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(_obscureText ? Iconfont.eyeoff : Iconfont.eyeon),
          ),
        ),
        style: TextStyle(
          color: AppColors.fontGrey,
          fontFamily: "SFProText",
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        maxLines: 1,
        autocorrect: false, // 自动纠正
        // 隐藏输入内容, 密码框
      ),
    );
  }
}
