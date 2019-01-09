import 'package:flutter/material.dart';

// 默认边框
const BorderSide _defaultBorder = BorderSide(width: 0.8, color: Color(0xffD9D9D9));

class WeGrid extends StatefulWidget {
  final List<Widget> children;
  final int count;
  final BorderSide border;

  WeGrid({
    @required this.children,
    this.count = 3,
    this.border = _defaultBorder
  });

  @override
  WeGridState createState() => WeGridState();
}

class WeGridState extends State<WeGrid> {
  GlobalKey _boxKey = GlobalKey();
  double _itemWidth = 0.0;

  WeGridState() {
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  void init(time) {
    setState(() {
      _itemWidth = _boxKey.currentContext.size.width / widget.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    // 计算行数
    final int rowNum = (widget.children.length / 3).ceil();

    // 行数
    for (int rowIndex = 0; rowIndex < rowNum; rowIndex++) {
      final List<Widget> list = [];

      // 列数
      for (int index = 0; index < widget.count; index++) {
        final int eq = (rowIndex * widget.count) + index;
        if (eq <= widget.children.length - 1) {
          list.add(SizedBox(
            width: _itemWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: rowIndex == 0 ? widget.border : BorderSide.none,
                  right: widget.border,
                  bottom: widget.border,
                  left: index == 0 ? widget.border : BorderSide.none
                )
              ),
              child: widget.children[eq]
            )
          ));
        }
      }

      children.add(Row(
        children: list
      ));
    }

    return SizedBox(
      key: _boxKey,
      child: Column(
        children: children
      )
    );
  }
}
