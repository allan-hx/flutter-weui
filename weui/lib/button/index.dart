import 'package:flutter/material.dart';
import '../animation/rotating.dart';
import '../theme.dart';
import '../icon/index.dart';

// 颜色类型
enum WeButtonType {
  acquiescent,
  primary,
  warn
}

// size
enum WeButtonSize {
  acquiescent,
  mini
}

class WeButton extends StatefulWidget {
  // 内容
  dynamic child;
  // 禁用
  final bool disabled;
  // 点击回调
  final Function onClick;
  // loading
  final bool loading;
  // 按钮大小类型
  WeButtonSize sizeType;
  // 按钮主题
  Map<String, Color> theme;
  // 按钮大小
  Map<String, double> size;
  // 主题
  final List<Map<String, Color>> themeConfig = [
    // 默认
    {
      'backgroundColor': defaultBackgroundColor,
      'fontColor': Colors.black,
      'disabledBackgroundColor': Color(0xfff7f7f7),
      'borderColor': Color(0xffc6c6c6),
      'hollowColor': Color(0xff353535)
    },
    // primary
    {
      'backgroundColor': primary,
      'fontColor': Colors.white,
      'disabledBackgroundColor': primaryDisabled,
      'borderColor': Color(0xffc6c6c6),
      'hollowColor': primary
    },
    // warn
    {
      'backgroundColor': warn,
      'fontColor': Colors.white,
      'disabledBackgroundColor': warnDisabled,
      'borderColor': Color(0xffc6c6c6),
      'hollowColor': warn
    }
  ];
  // 大小配置
  final List<Map<String, double>> sizeConfig = [
    {
      'fontSize': 18.0,
      'height': 45.0,
      'iconSize': 16.0,
      'borderSize': 0.5
    },
    {
      'fontSize': 13.0,
      'height': 30.0,
      'iconSize': 14.0,
      'borderSize': 0.4
    }
  ];

  WeButton(
    this.child,
    {
      this.onClick,
      WeButtonSize size = WeButtonSize.acquiescent,
      hollow = false,
      WeButtonType theme = WeButtonType.acquiescent,
      this.disabled = false,
      this.loading = false,
    }
  ) {
    this.size = sizeConfig[size.index];
    this.sizeType = size;
    final themeConf = themeConfig[theme.index];
    // 判断是否空心
    if (hollow) {
      this.theme = {
        'backgroundColor': Colors.transparent,
        'fontColor': themeConf['hollowColor'],
        'disabledBackgroundColor': null,
        'borderColor': themeConf['hollowColor']
      };
    } else {
      this.theme = themeConf;
    }
  }

  @override
  _ButtonState createState() => _ButtonState();
}
class _ButtonState extends State<WeButton> {
  // 按钮点击
  onClick() {
    if (widget.onClick is Function) {
      widget.onClick();
    }
  }

  // 渲染按钮内容
  Widget renderChild(content) {
    // size
    final size = widget.size;
    // 是否禁用状态
    final bool disabled = widget.loading || widget.disabled;
    Widget child;
    if (content is String) {
      child = Text(content);
    } else {
      child = content;
    }

    // 内容
    List<Widget> children = [
      DefaultTextStyle(
        style: TextStyle(
          fontSize: size['fontSize'],
          color: widget.theme['fontColor']
        ),
        child: child
      )
    ];

    if (widget.loading) {
      final Widget icon = Padding(
        padding: EdgeInsets.only(right: 5),
        child: Rotating(Icon(
          WeIcons.loading,
          color: widget.theme['fontColor'],
          size: size['iconSize']
        ))
      );
      children.insert(0, icon);
    }

    return Opacity(
      opacity: disabled ? 0.7 : 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: widget.sizeType == WeButtonSize.mini ? MainAxisSize.min : MainAxisSize.max,
        children: children
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // size
    final size = widget.size;
    final theme = widget.theme;
    // 是否禁用状态
    final bool disabled = widget.loading || widget.disabled;
    // 圆角
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));
    // 按钮
    final Widget button = Container(
      height: size['height'],
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: disabled ? theme['disabledBackgroundColor'] : null,
        borderRadius: borderRadius,
        border: Border.all(width: size['borderSize'], color: theme['borderColor'])
      ),
      child: renderChild(widget.child)
    );

    // 禁用状态
    if (disabled) {
      return button;
    }

    return Material(
      borderRadius: borderRadius,
      color: widget.theme['backgroundColor'],
      child: InkWell(
        onTap: onClick,
        borderRadius: borderRadius,
        child: button
      )
    );
  }
}
