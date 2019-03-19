import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../theme/index.dart';
import '../animation/fade_in.dart';
import '../animation/scale.dart';
import './layout_hoc.dart';

final double _titleSize = 18.0;
final double _padding = boxPadding - 2;

class IosWidget extends StatefulWidget {
  // 标题
  final dynamic title;
  // 内容
  final dynamic message;
  // 按钮
  final dynamic buttons;

  IosWidget({
    key,
    this.title,
    this.message,
    this.buttons
  }) : super(key: key);

  @override
  IosWidgetState createState() => IosWidgetState();
}

class IosWidgetState extends State<IosWidget> {
  final GlobalKey _fadeInKey = GlobalKey();
  final GlobalKey _scaleKey = GlobalKey();
  final _intervalSize = 1 / MediaQueryData.fromWindow(ui.window).devicePixelRatio;
  WeTheme theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = WeUi.getTheme(context);
  }

  // 渲染按钮
  Widget _renderButton() {
    final List<Widget> children = [];
    // button高度
    final double footerHeight = 48.0;

    // 循环按钮
    for (int index = 0; index < widget.buttons.length; index++) {
      final item = widget.buttons[index];
      // isOne
      final bool isOne = index == 0;

      // 判断是个第一个 - 添加间隔
      if (!isOne) {
        children.add(
          SizedBox(
            width: _intervalSize,
            height: footerHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.defaultBorderColor
              )
            )
          )
        );
      }

      // 添加
      children.add(
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: item['onClick'],
            child: Align(
              alignment: Alignment.center,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: _titleSize,
                  color: widget.buttons.length > 1 && isOne ? Color(0xff555555) : theme.primaryColor
                ),
                child: item['widget']
              )
            )
          )
        )
      );
    }

    return SizedBox(
      height: footerHeight,
      child: Row(
        children: children
      )
    );
  }

  // 反向执行动画
  reverseAnimation() async {
    // 执行缩放动画
    (_scaleKey.currentState as ScaleState).controller.reverse();
    await (_fadeInKey.currentState as FadeInState).controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      // 内容
      Padding(
        padding: EdgeInsets.only(left: _padding, right: _padding, bottom: 16.0),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff808080)
          ),
          child: widget.message
        )
      ),
      Divider(height: 1.0, color: theme.defaultBorderColor),
      // 按钮
      _renderButton()
    ];

    // 标题
    if (widget.title != null) {
      children.insert(0, Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: _titleSize,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
          child: widget.title
        )
      ));
    }

    return layoutHoc(
      scaleKey: _scaleKey,
      fadeInKey: _fadeInKey,
      maskColor: theme.maskColor,
      children: children
    );
  }
}
