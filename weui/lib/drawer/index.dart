import 'package:flutter/material.dart';
import '../utils.dart';
import './drawer.dart';

export './drawer.dart';

typedef ShowDrawer = Function({
  // 是否显示mask
  bool mask,
  // 遮罩层点击关闭
  bool maskClosable,
  // 方向
  WeDrawerPlacement placement,
  // 内容
  @required Widget child
});
typedef CloseDrawer = Function();

ShowDrawer weDrawer(BuildContext context) {
  final GlobalKey widgetKey = GlobalKey();

  CloseDrawer showDrawer ({
    mask = true,
    maskClosable = true,
    placement = WeDrawerPlacement.left,
    onClose,
    child
  }) {
    Function remove;

    // 关闭方法
    close() async {
      // 反向执行动画
      await (widgetKey.currentState as DrawerWidgetState).reverseAnimation();
      // 执行回调
      if (onClose is Function) onClose();
      // 销毁
      remove();
    }

    remove = createOverlayEntry(
      context: context,
      child: DrawerWidget(
        key: widgetKey,
        mask: mask,
        placement: placement,
        maskClick: maskClosable ? close : null,
        child: child
      ),
      willPopCallback: close
    );

    return close;
  }

  return showDrawer;
}
