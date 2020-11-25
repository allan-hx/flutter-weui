import 'dart:async';
import 'package:flutter/material.dart';

typedef CloseBack = Function(int index);

// 字符串转Widget
Widget toTextWidget(content, key) {
  if (content == null) return null;
  // 判断是字符串或者是widget
  if (content is Widget == false && content is String == false) {
    throw new FormatException('$key类型只能为String || Widget');
  }

  if (content is String) {
    return Text(content);
  }

  return content;
}

// 创建OverlayEntry
Function() createOverlayEntry(
    {@required BuildContext context,
    @required Widget child,
    bool backIntercept = false,
    Function willPopCallback}) {
  final overlayState = Overlay.of(context);
  ModalRoute _route;

  OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText1, child: child);
  });
  overlayState.insert(overlayEntry);

  // 返回关闭
  Future<bool> backClose() {
    willPopCallback();
    return Future.value(false);
  }

  void close() {
    overlayEntry.remove();
    _route?.removeScopedWillPopCallback(backClose);
  }

  // 返回键拦截
  if (willPopCallback != null) {
    _route = ModalRoute.of(context);

    // back监听
    _route.addScopedWillPopCallback(backClose);
  }

  return close;
}

// 判断是否是true
bool isTrue(value) {
  return value is bool && value;
}
