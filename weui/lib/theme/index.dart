import 'package:flutter/material.dart';
import '../toast/index.dart';

const Color _primaryColor = Color(0xff1AAD19);
const Color _primaryColorDisabled = Color(0xff9ED99D);
const Color _warnColor = Color(0xffE64340);
const Color _warnColorDisabled = Color(0xffEC8B89);
const Color _defaultBackgroundColor = Color(0xfff8f8f8);
const Color _defaultBorderColor = Color(0xffd8d8d8);
const Color _maskColor = Color.fromRGBO(17, 17, 17, 0.6);

final _defaultTheme = WeTheme();
final _defaultConfig = WeConfig();

// 主题
class WeTheme {
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

  WeTheme({
    this.primaryColor = _primaryColor,
    this.primaryColorDisabled = _primaryColorDisabled,
    this.warnColor = _warnColor,
    this.warnColorDisabled = _warnColorDisabled,
    this.defaultBackgroundColor = _defaultBackgroundColor,
    this.defaultBorderColor = _defaultBorderColor,
    this.maskColor = _maskColor
  });
}

// 配置
class WeConfig {
  // toast 位置
  final WeToastInfoAlign toastInfoAlign;
  // toast info自动关闭时间
  final int toastInfoDuration;
  // toast loading关闭时间
  final int toastLoadingDuration;
  // toast success关闭时间
  final int toastSuccessDuration;
  // toast fail关闭时间
  final int toastFailDuration;
  // notify自动关闭时间
  final int notifyDuration;
  // notify成功关闭时间
  final int notifySuccessDuration;
  // notify错误关闭时间
  final int notifyErrorDuration;

  WeConfig({
    this.toastInfoAlign = WeToastInfoAlign.center,
    this.toastInfoDuration = 2500,
    this.toastLoadingDuration,
    this.toastSuccessDuration = 2500,
    this.toastFailDuration = 2500,
    this.notifyDuration = 3000,
    this.notifySuccessDuration = 3000,
    this.notifyErrorDuration = 3000,
  });
}

class WeUi extends InheritedWidget {
  final WeTheme theme;
  final WeConfig config;

  WeUi({
    Key key,
    this.theme,
    this.config,
    Widget child
  }) : super(key: key, child: child);

  static WeUi of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(WeUi);
  }

  // 获取主题配置
  static WeTheme getTheme(BuildContext context) {
    final WeUi weui = WeUi.of(context);
    return weui == null || weui.theme == null ? _defaultTheme : weui.theme;
  }

  // 获取全局配置
  static WeConfig getConfig(BuildContext context) {
    final WeUi weui = WeUi.of(context);
    return weui == null || weui.config == null ? _defaultConfig : weui.config;
  }

  @override
  bool updateShouldNotify(WeUi oldWidget) {
    return true;
  }
}
