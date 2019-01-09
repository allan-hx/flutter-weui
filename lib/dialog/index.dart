import 'package:flutter/material.dart';
import '../utils.dart';
import './android_widget.dart';
import '../theme.dart';
import './ios_widget.dart';

// 确认框
typedef Confirm = Function(dynamic message, {
  // 标题
  dynamic title,
  // 主题
  String theme,
  // 取消按钮
  dynamic cancelButton,
  // 确认按钮
  dynamic confirmButton,
  // 确认事件
  Function onConfirm,
  // 取消事件
  Function onCancel
});

// 弹窗
typedef Alert = Function(dynamic message, {
  // 标题
  dynamic title,
  // 主题
  String theme,
  // 按钮
  dynamic button,
  // 回调
  Function onConfirm
});

// 创建安卓主题dialog
_createAndroidLayout(BuildContext context, message, {
  // 标题
  dynamic title,
  // 主题
  String theme,
  // 弹窗类型
  String type,
  // 取消按钮
  dynamic cancelButton,
  // 取消事件
  Function onCancel,
  // 确认按钮
  dynamic confirmButton,
  // 确认事件
  Function onConfirm
}) {
  Function remove;
  // key
  final GlobalKey widgetKey = GlobalKey();
  Widget widget;

  // 关闭方法
  void close() async {
    // 判断执行反转动画
    if (theme == 'ios') {
      await (widgetKey.currentState as IosWidgetState).reverseAnimation();
    } else {
      await (widgetKey.currentState as AndroidWidgetState).reverseAnimation();
    }
    // 销毁
    remove();
  }

  // 取消
  void confirm() {
    if (onConfirm is Function) onConfirm();
    close();
  }

  // 确认
  void cancel() {
    if (onCancel is Function) onCancel();
    close();
  }

  // 按钮
  final List<Map<String, Object>> buttons = [
    // 确认按钮
    {
      'widget': toTextWidget(confirmButton, 'button'),
      'onClick': confirm
    }
  ];

  // 判断是否是confirm
  if (type == 'confirm') {
    buttons.insert(0, {
      'widget': toTextWidget(cancelButton, 'button'),
      'onClick': cancel
    });
  }

  // 判断主题
  switch (theme) {
    case 'ios':
      widget = IosWidget(
        key: widgetKey,
        title: toTextWidget(title, 'title'),
        message: toTextWidget(message, 'message'),
        theme: theme,
        buttons: buttons
      );
      break;
    default:
      widget = AndroidWidget(
        key: widgetKey,
        title: toTextWidget(title, 'title'),
        message: toTextWidget(message, 'message'),
        theme: theme,
        buttons: buttons
      );
  }

  remove = createOverlayEntry(
    context: context,
    color: maskColor,
    child: widget,
    willPopCallback: cancel
  );
}

class WeDialog {
  // alert
  static Alert alert(BuildContext context) {
    return (
      message,
      {
        title = '提示',
        theme = 'ios',
        button = '确认',
        onConfirm
      }
    ) {
      _createAndroidLayout(
        context,
        message,
        title: title,
        theme: theme,
        type: 'alert',
        confirmButton: button,
        onConfirm: onConfirm
      );
    };
  }

  // android
  static Confirm confirm(BuildContext context) {
    return (
      message,
      {
        title = '提示',
        theme = 'ios',
        cancelButton = '取消',
        onCancel,
        confirmButton = '确认',
        onConfirm 
      }
    ) {
      _createAndroidLayout(
        context,
        message,
        title: title,
        theme: theme,
        type: 'confirm',
        cancelButton: cancelButton,
        onCancel: onCancel,
        confirmButton: confirmButton,
        onConfirm: onConfirm
      );
    };
  }
}
