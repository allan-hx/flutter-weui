import 'package:flutter/material.dart';
import './android_widget.dart';
import './ios_widget.dart';
import '../utils.dart';

// 关闭函数
typedef Close = Function();
// change
typedef OnChange = Function(int index);
// 安卓
typedef WeActionsheetAndroid = Function({
  @required List<dynamic> childer,
  Close onClose,
  bool maskClosable,
  OnChange onChange
});
// ios
typedef WeActionsheetIos = Function({
  dynamic title,
  @required List<dynamic> childer,
  bool maskClosable,
  dynamic cancelButton,
  Close onClose,
  OnChange onChange
});

// WeActionsheet
class WeActionsheet {
  // 安卓样式
  static WeActionsheetAndroid android(BuildContext context) {
    return ({ maskClosable = true, onClose, onChange, childer }) {
      final GlobalKey widgetKey = GlobalKey();
      Function remove;

      // 关闭
      void hide() {
        remove();
        if (onClose is Function) {
          onClose();
        }
      }

      // 点击
      void itemClick(int index) {
        remove();
        if (onChange is Function) {
          onChange(index);
        }
      }

      remove = createOverlayEntry(
        context: context,
        backIntercept: true,
        child: AndroidWidget(
          key: widgetKey,
          maskClosable: maskClosable,
          close: hide,
          onChange: itemClick,
          childer: childer
        ),
        willPopCallback: () {
          (widgetKey.currentState as AndroidWidgetState).close();
        }
      );
    };
  }

  // ios 样式
  static WeActionsheetIos ios(BuildContext context) {
    return ({ title, childer, maskClosable = true, cancelButton, onClose, onChange }) {
      final GlobalKey widgetKey = GlobalKey();
      Function remove;

      // 关闭
      void hide() {
        remove();
        if (onClose is Function) {
          onClose();
        }
      }

      // 点击
      void itemClick(int index) {
        remove();
        if (onChange is Function) {
          onChange(index);
        }
      }

      remove = createOverlayEntry(
        context: context,
        backIntercept: true,
        child: IosWidget(
        key: widgetKey,
          title: title,
          cancelButton: cancelButton,
          maskClosable: maskClosable,
          close: hide,
          onChange: itemClick,
          childer: childer
        ),
        willPopCallback: () {
          (widgetKey.currentState as IosWidgetState).close();
        }
      );
    };
  }
}
