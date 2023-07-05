import 'package:intl/intl.dart';

/// 取当前时间戳
int duTimeMillis(int days) {
  return DateTime.now().add(new Duration(days: -days)).millisecondsSinceEpoch;
}

/// 格式化时间
String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  // 1分钟内
  if (difference.inMinutes < 1) {
    return "${difference.inSeconds} sec. ago";
  }
  // 1小时内
  else if (difference.inHours < 1) {
    return "${difference.inMinutes} min. ago";
  }
  // 1天内
  else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  }
  // 30天内
  else if (difference.inDays < 30) {
    return "${difference.inDays} days ago";
  }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}

String duDateFormat(DateTime dt) {
  // var now = DateTime.now();
  // var difference = now.difference(dt);
  final dtFormat =
      new DateFormat('h:m:s a \n MMM. d, yy'); //10:34 AM Apr. 14, 20
  var str = dtFormat.format(dt);
  return str;
}

String duFullDateFormat(DateTime dt) {
  // var now = DateTime.now();
  // var difference = now.difference(dt);
  final dtFormat = new DateFormat('H:m yyyy-MM-dd'); //10:34 AM Apr. 14, 20
  var str = dtFormat.format(dt);
  return str;
}
