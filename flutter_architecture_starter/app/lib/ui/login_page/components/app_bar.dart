import 'dart:ui';
import 'package:app/core/constants/colors.dart';
import 'package:app/core/constants/global.dart';
import 'package:flutter/material.dart';

// import 'package:luci_thermal_personal_app/common/values/values.dart';
// import 'package:luci_thermal_personal_app/global.dart';

/// 透明背景 AppBar
Widget transparentAppBar({
  @required BuildContext context,
  List<Widget> actions,
  leadingIconColr = AppColors.primaryText,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    brightness: Brightness.light,
    centerTitle: true,
    title: Text(''),
    leading: Global.isShowleadingIcon == false
        ? Text('')
        : IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: leadingIconColr,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
    actions: actions,
  );
}

// /// application Page AppBar
// Widget applicationPageAppBar({
//   @required BuildContext context,
//   List<Widget> actions,
//   String title,
//   String name,
// }) {
//   return AppBar(
//     backgroundColor: AppColors.primaryAppWhite,
//     elevation: 0,
//     brightness: Brightness.light, //设置风格，状态栏的文字颜色变成黑色
//     centerTitle: true,
//     title: Text(
//       title,
//       style: TextStyle(
//         color: AppColors.primaryText,
//         fontSize: 18.0,
//         height: 1.2,
//         fontFamily: "SFProText",
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     /// 左侧按钮
//     leading: btnNameAvatarButtonWidget(
//       onPressed: () {
//         Navigator.pushNamed(
//           context,
//           "/profile",
//         ).then((value){
//           print(value);
//           print(Global.shortName);
//           name = Global.shortName;
//         } );
//       },
//       avatarName:name,
//     ),
//     bottom: PreferredSize(
//       child: Container(
//         color: AppColors.firstBorder,
//         height: 0.5,
//       ),
//       preferredSize: Size.fromHeight(4.0)),
// // AppBar(

//     // 右侧按钮
//     actions: actions,
//   );
// }
