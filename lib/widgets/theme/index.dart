/*
 * @Author: Allan 
 * @Date: 2021-03-11 22:53:33 
 * @explain: 主题和配置
 * @Last Modified time: 2021-03-11 22:53:33 
 */

// 主题配置
import 'package:flutter/widgets.dart';

class WeTheme {
  const WeTheme({
    this.colorPrimary = const Color(0xff07c160),
    this.colorSuccess = const Color(0xff07c160),
    this.colorDanger = const Color(0xff07c160),
  });

  // 主色
  final Color colorPrimary;
  // 成功色
  final Color colorSuccess;
  // 警告色
  final Color colorDanger;
}

// 全局配置
class WeConfig {
  const WeConfig();
}

class Weui {
  const Weui({
    WeTheme? theme,
    WeConfig? config,
  })  : theme = theme ?? const WeTheme(),
        config = config ?? const WeConfig();

  // 主题
  final WeTheme? theme;
  // 配置
  final WeConfig? config;
}
