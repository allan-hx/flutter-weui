import 'package:flutter/material.dart';
import '../icon/index.dart';
import '../utils.dart';
import '../theme.dart';

class WeCollapse extends StatefulWidget {
  // 默认展示
  final List<int> defaultActive;
  // 变化回调
  final Function(List<int> value) onChange;
  // 手风琴模式
  final bool accordion;
  // 数据
  final List<Map<String, Object>> options;

  WeCollapse({
    this.defaultActive,
    this.onChange,
    this.accordion = false,
    @required this.options
  });

  @override
  WeCollapseState createState() => WeCollapseState();
}

class WeCollapseState extends State<WeCollapse> {
  // 左右padding
  final double titleOrSoPadding = 19.0;
  // 上下padding
  final double titleUpAndDownPadding = 13.0;
  // 边框
  final Widget border = Divider(height: 1, color: defaultBorderColor);
  List<int> activeIndex = [];

  @override
  void initState() { 
    super.initState();
    if (widget.defaultActive != null) {
      activeIndex = widget.defaultActive;
    }
  }

  void onClick(int index) {
    List<int> activeList = activeIndex;
    if (activeList.indexOf(index) >= 0) {
      activeList.remove(index);
    } else {
      // 手风琴模式判断
      if (widget.accordion) {
        activeList = [index];
      } else {
        activeList.add(index);
      }
    }

    setState(() {
      activeIndex = activeList;
      widget.onChange is Function && widget.onChange(activeList);
    });
  }

  // 渲染title
  Widget renderTitle(int index, Widget title) {
    final bool checked = activeIndex.indexOf(index) >= 0;

    return InkWell(
      onTap: () {
        onClick(index);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: titleUpAndDownPadding,
          right: titleOrSoPadding,
          bottom: titleUpAndDownPadding,
          left: titleOrSoPadding
        ),
        child: Row(
          children: [
            // title
            Expanded(
              flex: 1,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff333333)
                ),
                child: title
              )
            ),
            // icon
            Transform.rotate(
              angle: checked ? (-180 ~/ 30) * 30.0 * 0.0174533 : 0.0,
              child: Icon(WeIcons.down, size: 26.0, color: Color(0xff969799))
            )
          ]
        )
      )
    );
  }

  // 渲染内容
  Widget renderContent(int index, Widget content) {
    return Padding(
      padding: EdgeInsets.only(
        right: titleOrSoPadding,
        bottom: titleOrSoPadding,
        left: titleOrSoPadding
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              border,
              Container(
                // color: Colors.red,
                padding: EdgeInsets.only(top: titleOrSoPadding),
                child: content
              )
            ]
          )
        )
      )
    );
  }

  Widget renderItem(int index, Map<String, Object> item) {
    final List<Widget> children = [renderTitle(index, toTextWidget(item['title'], 'title'))];

    // 内容
    if (activeIndex.indexOf(index) >= 0) {
      children.add(renderContent(index, toTextWidget(item['child'], 'child')));
    }

    return SizedBox(
      child: Column(
        children: children
      )
    );
  }

  renderChildren(list) {
    final List<Widget> children = [];

    // 遍历
    for (int index = 0; index < list.length; index++) {
      children.add(border);
      children.add(renderItem(index, list[index]));
    }

    // 末尾边框
    children.add(border);

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        color: Colors.white,
        child: Column(
          children: renderChildren(widget.options)
        )
      )
    );
  }
}
