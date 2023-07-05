import 'dart:async';

late Timer _timer;
void startTimer(
  void Function(Timer) method, {
  int periodSec = 1,
}) {
  //默认设置 1 秒回调一次
  var period = Duration(seconds: periodSec);
  _timer = Timer.periodic(period, method);
}

/// 测试
/// 正常情况应该是每秒打印一次
main() {
  int times = 0;
  startTimer((timer) {
    times += 1;
    print('定时器循环运行' + times.toString());
  });
}
