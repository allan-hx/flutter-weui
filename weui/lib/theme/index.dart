import 'package:flutter/material.dart';

// 默认值
const Color _primaryColor = Color(0xff1AAD19);
const Color _primaryColorDisabled = Color(0xff9ED99D);
const Color _warnColor = Color(0xffE64340);
const Color _warnColorDisabled = Color(0xffEC8B89);
const Color _defaultBackgroundColor = Color(0xfff8f8f8);
const Color _defaultBorderColor = Color(0xffd8d8d8);
const Color _maskColor = Color.fromRGBO(17, 17, 17, 0.6);

// 主题
class Wetheme {
    // 主色
  final Color primaryColor;
    // 主色禁用
  final Color primaryColorDisabled;
  // 警告色
  final Color warnColor;
  // 警告色禁用
  final Color warnColorDisabled;
  // 默认背景色
  final Color defaultBackgroundColor;
  // 默认边框色
  final Color defaultBorderColor;
  // 遮罩层颜色
  final Color maskColor;

  Wetheme({
    this.primaryColor = _primaryColor,
    this.primaryColorDisabled = _primaryColorDisabled,
    this.warnColor = _warnColor,
    this.warnColorDisabled = _warnColorDisabled,
    this.defaultBackgroundColor = _defaultBackgroundColor,
    this.defaultBorderColor = _defaultBorderColor,
    this.maskColor = _maskColor
  });
}

class WeUi extends InheritedWidget {
  final Wetheme theme;

  WeUi({
    Key key,
    this.theme,
    Widget child
  }) : super(key: key, child: child);

  static WeUi of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(WeUi);
  }

  @override
  bool updateShouldNotify(WeUi oldWidget) {
    return true;
  }
}