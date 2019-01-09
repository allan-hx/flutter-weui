import 'package:flutter/material.dart';
import '../utils.dart';
import './info.dart';
import './toast.dart';
import '../animation/rotating.dart';
import '../icon/index.dart';

// 对齐方式
enum WeToastInfoAlign {
  // 上对齐
  top,
  // 居中
  center,
  // 下对齐
  bottom
}

// 默认关闭时间
const int defaultDuration = 2500;
// loading icon
final Widget _loadingIcon = Image.asset('assets/images/loading.png', height: 42.0);
// success icon
const Widget _successIcon = Icon(WeIcons.hook, color: Colors.white, size: 49.0);
// fail icon
const Widget _failIcon = Icon(WeIcons.info, color: Colors.white, size: 49.0);
// info
typedef _info = Function(dynamic message, { int duration, WeToastInfoAlign align, double distance });
// loading
typedef _loading = Function({ dynamic message, int duration, bool mask, Widget icon });
// success
typedef _success = Function({ dynamic message, int duration, bool mask, Widget icon });
// fail
typedef _fail = Function({ dynamic message, int duration, bool mask, Widget icon });
// toast
typedef _toast = Function({ dynamic message, int duration, bool mask, Widget icon });
// loading close
typedef _close = Function();

class WeToast {
  static final List<String> _weToastAlign = ['top', 'center', 'bottom'];

  // 信息提示
  static _info info(BuildContext context) {
    return (message, { duration = defaultDuration, align = WeToastInfoAlign.center, distance = 100.0 }) async {
      // 转换
      final Widget messageWidget = toTextWidget(message, 'message');
      final remove = createOverlayEntry(
        context: context,
        child: InfoWidget(
          messageWidget,
          align: _weToastAlign[align.index],
          distance: distance
        )
      );

      // 自动关闭
      await Future.delayed(Duration(milliseconds: duration));
      remove();
    };
  }

  // 加载中
  static _loading loading(BuildContext context) {
    _close show({ message, duration, mask = true, icon }) {
      icon = icon == null ? _loadingIcon : icon;

      return WeToast.toast(context)(
        icon: Rotating(icon, duration: 800),
        mask: mask,
        message: message,
        duration: duration
      );
    }

    return show;
  }

  // 成功
  static _success success(BuildContext context) {
    return ({ message, duration = defaultDuration, mask = true, icon = _successIcon }) {
      WeToast.toast(context)(
        icon: icon,
        mask: mask,
        message: message,
        duration: duration
      );
    };
  }

  // 失败
  static _fail fail(BuildContext context) {
    return ({ message, duration = defaultDuration, mask = true, icon = _failIcon }) {
      WeToast.toast(context)(
        icon: icon,
        mask: mask,
        message: message,
        duration: duration
      );
    };
  }

  // 提示
  static _toast toast(BuildContext context) {
    return ({ message, duration, mask = true, icon }) {
      // 转换
      final Widget messageWidget = toTextWidget(message, 'message');
      final remove = createOverlayEntry(
        context: context,
        child: ToastWidget(
          message: messageWidget,
          mask: mask,
          icon: icon
        )
      );

      void close() {
        remove();
      }

      // 自动关闭
      if (duration != null) {
        Future.delayed(Duration(milliseconds: duration), close);
      }

      return close;
    };
  }
}
