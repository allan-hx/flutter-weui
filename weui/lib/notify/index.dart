import 'package:flutter/material.dart';
import './notify.dart';
import '../utils.dart';
import '../theme.dart';

typedef _Notify = Function ({
  int duration,
  @required Widget child
});

typedef _Show = Function ({
  Color color,
  int duration,
  @required Widget child
});

class WeNotify {
  // 成功
  static _Notify success (BuildContext context) {
    return ({ duration = 3000, child }) {
      WeNotify.show(context)(
        color: primary,
        duration: duration,
        child: child
      );
    };
  }

  // 失败
  static error (BuildContext context) {
    return ({ duration = 3000, child }) {
      WeNotify.show(context)(
        color: warn,
        duration: duration,
        child: child
      );
    };
  }

  static _Show show (BuildContext context) {
    return ({ color = warn, duration = 3000, child }) {
      final GlobalKey widgetKey = GlobalKey();
      final Function remove = createOverlayEntry(
        context: context,
        child: NotifyWidget(
          key: widgetKey,
          color: color,
          child: child
        )
      );

      void close() async {
        // 反向执行动画
        await (widgetKey.currentState as NotifyWidgetState).reverseAnimation();
        remove();
      }

      Future.delayed(Duration(milliseconds: duration), close);
    };
  }
}