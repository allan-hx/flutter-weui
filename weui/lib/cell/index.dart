import 'package:flutter/material.dart';
import '../theme.dart';

// 边框
const Divider _border = Divider(height: 1, color: defaultBorderColor);
// 间距
const double _spacing = 20.0;

class WeCells extends StatelessWidget {
  final bool boxBorder;
  final double spacing;
  List<Widget> children;

  WeCells({
    this.boxBorder = true,
    this.spacing = _spacing,
    @required children,
  }) {
    final List<Widget> newChildren = [];
    children.forEach((item) {
      if (item != children[0]) {
        newChildren.add(
          Padding(
            padding: EdgeInsets.only(left: spacing),
            child: _border
          )
        );
      }
      newChildren.add(item);
    });

    // 判断是否添加容器边框
    if (boxBorder) {
      newChildren.add(_border);
      newChildren.insert(0, _border);
    }

    this.children = newChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: children
      )
    );
  }
}

class WeCell extends StatelessWidget {
  // label
  Widget label;
  // 内容
  Widget content;
  // footer
  final Widget footer;
  // 对齐方式
  final Alignment align;
  // 间距
  final double spacing;
  // 最小高度
  final double minHeight;
  // 点击
  final Function onClick;

  WeCell({
    label,
    content,
    this.footer,
    this.align = Alignment.centerRight,
    this.spacing = _spacing,
    this.minHeight = 46.0,
    this.onClick
  }) {
    // label
    if (label is String) {
      this.label = Text(label);
    } else {
      this.label = label;
    }

    // content
    if (content is String) {
      this.content = Text(content);
    } else {
      this.content = content;
    }
  }

  // 点击
  void onTap() {
    onClick();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    // label
    if (label is Widget) {
      children = [
        label
      ];

      if (content is Widget) {
        children.add(
          Expanded(
            flex: 1,
            child: Align(
              alignment: align,
              child: content
            )
          )
        );
      }
    } else {
      children = [
        Expanded(
          flex: 1,
          child: content
        )
      ];
    }

    // footer
    if (footer != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: footer
        )
      );
    }

    final child = Container(
      constraints: BoxConstraints(
        minHeight: minHeight
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
        ),
        child: Padding(
          padding: EdgeInsets.only(left: spacing, right: spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children
          )
        )
      )
    );

    if (onClick == null) {
      return child;
    }

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: child
      )
    );
  }
}
