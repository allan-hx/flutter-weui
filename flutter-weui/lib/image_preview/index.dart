import 'package:flutter/material.dart';
import './preview_widget.dart';
import '../utils.dart';

// 默认背景色
const Color _maskDefaultColor = Color.fromRGBO(0, 0, 0, 0.8);

typedef WeImagePreview = Function({
  // 图片
  @required List<String> images,
  // 背景色
  Color color,
  // 默认展示
  int defaultIndex,
  // 指标显示
  bool indicators
});

WeImagePreview weImagePreview(BuildContext context) {
  final GlobalKey widgetKey = GlobalKey();
  Function remove;
  Function show({
    images,
    color = _maskDefaultColor,
    defaultIndex = 0,
    indicators = true
  }) {
    // 关闭方法
    close() async {
      // 反序播放动画
      await (widgetKey.currentState as PreviewState).reverseAnimation();
      remove();
    }

    remove = createOverlayEntry(
      context: context,
      child: Preview(
        key: widgetKey,
        images: images,
        color: color,
        maskClick: close,
        defaultIndex: defaultIndex,
        indicators: indicators
      ),
      willPopCallback: close
    );

    return close;
  }

  return show;
}
