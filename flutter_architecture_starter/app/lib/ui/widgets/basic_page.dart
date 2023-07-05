import 'package:flutter/material.dart';
import 'drawer.dart';

Widget buildBasicPage(
  BuildContext context, {
  Widget pageBody,
  String pageTitle,
}) {
  return pageTitle == 'Home'
      ? _buildHomePage(context, pageBody: pageBody, pageTitle: pageTitle)
      : _buildPage(context, pageBody: pageBody, pageTitle: pageTitle);
}

Widget _buildHomePage(
  BuildContext context, {
  Widget pageBody,
  String pageTitle,
}) {
  return Scaffold(
    backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
    appBar:
        AppBar(title: Text(pageTitle)), //buildAppBar(context, title: 'Home'),
    body: pageBody,
    drawer: buildDrawer(context),
  );
}

Widget _buildPage(
  BuildContext context, {
  Widget pageBody,
  String pageTitle,
}) {
  return Scaffold(
    backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
    appBar:
        AppBar(title: Text(pageTitle)), //buildAppBar(context, title: 'Home'),
    body: pageBody,
  );
}
