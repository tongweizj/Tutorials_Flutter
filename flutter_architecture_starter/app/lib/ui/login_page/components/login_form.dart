// 登录表单
import 'package:app/core/constants/colors.dart';
import 'package:app/core/constants/radii.dart';
import 'package:app/core/services/users.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'input_Password.dart';

Widget buildLoginForm(
    BuildContext context,
    TextEditingController _emailController,
    TextEditingController _passController) {
  // String _password;
  // final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  return Container(
    width: 375.w,
    height: 300.h,
    margin: EdgeInsets.only(top: 40.h),
    padding: EdgeInsets.only(
      top: 20.h,
      left: 32.w,
      right: 32.w,
    ),
    // decoration: BoxDecoration(
    //   color: AppColors.primaryBackground,
    // ),
    child: Column(
      children: [
        // email input
        inputEmailEdit(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "Email",
          marginTop: 0,
        ),
        // password input
        InputPassword(
          controller: _passController,
          keyboardType: TextInputType.visiblePassword,
          hintText: "Password",
          isPassword: true,
        ),

        // 登录按钮
        btnFlatIconButtonWidget(
          onPressed: () =>
              _handleLogin(context, _emailController, _passController),
          width: 260,
          height: 30.h,
          marginTop: 25.h,
          gbColor: AppColors.primaryColor,
          iconFileName: "secure_login",
        ),
        // Spacer(),

        // Fogot password
        Container(
          height: 22.h,
          margin: EdgeInsets.only(top: 27.h),
          child: FlatButton(
            onPressed: () => _handleForgot(),
            child: Text(
              "Forgot credentials?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: "SFProText",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1, // 设置下行高，否则字体下沉
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// 执行登录操作
_handleLogin(BuildContext context, TextEditingController _emailController,
    TextEditingController _passController) async {
  Navigator.pushNamed(
    context,
    "/home",
  );

  // /// 1. 表单数据校验
  // if (!checkIsEmail(_emailController.value.text)) {
  //   toastInfo(msg: 'Please check your email!');
  //   return;
  // }
  // if (!checkStringLength(_passController.value.text, 6)) {
  //   toastInfo(msg: 'Please check your password!');
  //   return;
  // }

  // /// 2.登录
  // // Map userProfile = await UserControl.doUserLogin(
  // //     _emailController.value.text, _passController.value.text);
  // Map userProfile = await UsersAPI.login(
  //     username: _emailController.value.text,
  //     passwd: _passController.value.text);

  // /// 3.根据登录返回数据
  // if (userProfile['code'] == 1) {
  //   /// 注册通知服务
  //   // var params = {
  //   //   "data": {
  //   //     "email": _emailController.value.text,
  //   //     "registrationToken": _firebaseMessagingToken,
  //   //     "app": "luci_temp",
  //   //     "mobile_sys": "android"
  //   //   },
  //   //   "credential": Global.credential
  //   // };
  //   // NotifyAPI.postUserRegister();

  //   /// 跳转首页
  //   Navigator.pushNamed(
  //     context,
  //     "/home",
  //   );
  // } else {
  //   toastInfo(msg: userProfile['message']);
  // }
}

// 执行忘记密码操作
_handleForgot() async {
  // Navigator.pushNamed(
  //   context,
  //   "/forgetpw",
  // );
}

/// 输入框
Widget inputTextEdit({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String hintText,
  bool isPassword = false,
  double marginTop = 15,
}) {
  return Container(
    height: 40.h,
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
    constraints: BoxConstraints(
      minWidth: 180,
      minHeight: 40,
    ),
    height: 40.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
        color: AppColors.textFieldBG,
        borderRadius: Radii.k4pxRadius,
        border: Border.all(width: 1, color: AppColors.primaryBorder)),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.fontGrey),
        contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 1),
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

/// 扁平圆角图片按钮
Widget btnFlatIconButtonWidget({
  @required VoidCallback onPressed,
  double width = 140,
  double height = 40,
  Color gbColor = AppColors.primaryBackground,
  String iconFileName,
  double marginTop = 15,
}) {
  return Container(
    width: width.w,
    height: height.h,
    constraints: BoxConstraints(
      minWidth: 180,
      minHeight: 30,
    ),
    margin: EdgeInsets.only(top: marginTop.h),
    child: FlatButton(
      onPressed: onPressed,
      color: gbColor,
      shape: RoundedRectangleBorder(
        borderRadius: Radii.k27pxRadius,
      ),
      child: Image.asset(
        "assets/images/icons_$iconFileName.png",
      ),
    ),
  );
}
