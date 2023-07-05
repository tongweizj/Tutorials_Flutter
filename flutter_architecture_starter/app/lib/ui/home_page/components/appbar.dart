import 'package:app/core/constants/colors.dart';
import 'package:app/core/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// appBar组件
Widget buildAppBar(
  @required BuildContext context, {
  String title,
  List<Widget> actions,
}) {
  return AppBar(
    automaticallyImplyLeading: false, // Don't show the leading button
    backgroundColor: AppColors.primaryAppWhite,
    elevation: 0,
    brightness: Brightness.light, //设置风格，状态栏的文字颜色变成黑色
    centerTitle: true,
    title: appBarTitle(title),
    // title: Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     Builder(
    //       builder: (BuildContext context) {
    //         return IconButton(
    //           icon: const Icon(
    //             Icons.menu,
    //             color: AppColors.secondaryText,
    //           ),
    //           onPressed: () {
    //             Scaffold.of(context).openDrawer();
    //           },
    //           tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    //         );
    //       },
    //     ),
    //     Spacer(),
    //     appBarTitle(title),
    //     Spacer(),
    //     // Your widgets here
    //   ],
    // ),

    /// 左侧按钮
    // leading: demoButton(), //NameAvatarBtn(),
    bottom: PreferredSize(
        child: Container(
          color: AppColors.firstBorder,
          height: 0.5.h,
        ),
        preferredSize: Size.fromHeight(4.0)),
    // 右侧按钮
    actions: actions,
  );
}

Widget appBarTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      color: AppColors.primaryText,
      fontSize: 16.0,
      // height: duSetHeight(1.2),
      fontFamily: "SFProText",
      fontWeight: FontWeight.w600,
    ),
  );
}
