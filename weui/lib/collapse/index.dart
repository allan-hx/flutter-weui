import 'package:flutter/material.dart';
import '../icon/index.dart';
import '../theme/index.dart';

class WeCollapse extends StatefulWidget {
  // 数据
  final List<WeCollapseItem> children;
  // 默认展示
  final List<String> defaultActive;
  // 动画过度时间
  final int duration;
  // 卡片展示
  final bool card;
  // 卡片间距
  final double clearance;
  // 渲染标题
  final Widget Function(bool open, int index, Widget child) buildTitle;
  // 渲染内容
  final Widget Function(bool open, int index, Widget child) buildContent;
  // 变化回调
  final Function(List<String>) onChange;
  // 手风琴模式
  final bool accordion;

  WeCollapse({
    @required this.children,
    this.defaultActive,
    this.duration = 150,
    this.card = false,
    this.clearance = 13.0,
    this.buildTitle,
    this.buildContent,
    this.onChange,
    this.accordion = false
  });

  @override
  WeCollapseState createState() => WeCollapseState();
}

class WeCollapseState extends State<WeCollapse> {
  // 内容左右padding
  double borderPadding = 19.0;
  // title左右padding
  final double titleOrSoPadding = 19.0;
  // 上下padding
  final double titleUpAndDownPadding = 13.0;
  // 边框
  Widget border;
  // 当前激活
  List<String> activeIndex = [];

  @override
  void initState() {
    super.initState();

    if (widget.card) {
      borderPadding = 0.0;
    }

    if (widget.defaultActive != null) {
      activeIndex = widget.defaultActive;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    border = Divider(height: 1, color: WeUi.getTheme(context).defaultBorderColor);
  }

  void onClick(String key) {
    List<String> activeList = activeIndex;
    if (activeList.indexOf(key) >= 0) {
      activeList.remove(key);
    } else {
      // 手风琴模式判断
      if (widget.accordion) {
        activeList = [key];
      } else {
        activeList.add(key);
      }
    }

    setState(() {
      activeIndex = activeList;
    });

    if (widget.onChange is Function) widget.onChange(activeList);
  }

  // 渲染title
  Widget buildTitle(String key, int index, WeCollapseItem item) {
    final bool checked = activeIndex.indexOf(key) >= 0;
    Widget titleWidget;

    if (widget.buildTitle is Function) {
      titleWidget = widget.buildTitle(checked, index, item.title);
    } else {
      titleWidget = Padding(
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
                child: item.title
              )
            ),
            // icon
            Transform.rotate(
              angle: checked ? (-180 ~/ 30) * 30.0 * 0.0174533 : 0.0,
              child: Icon(WeIcons.down, size: 26.0, color: Color(0xff969799))
            )
          ]
        )
      );
    }

    return InkWell(
      onTap: () {
        onClick(key);
      },
      child: titleWidget
    );
  }

  // 渲染内容
  Widget buildContent(bool open, int index, Widget content) {
    Widget childWidget;

    if (widget.buildContent is Function) {
      childWidget = widget.buildContent(open, index, content);
    } else {
      childWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: borderPadding
            ),
            child: border
          ),
          Padding(
            padding: EdgeInsets.only(
              top: titleOrSoPadding,
              right: titleOrSoPadding,
              bottom: titleOrSoPadding,
              left: titleOrSoPadding
            ),
            child: content
          )
        ]
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black
        ),
        child: childWidget
      )
    );
  }

  Widget buildItem(String key, int index, WeCollapseItem item) {
    final List<Widget> children = [buildTitle(key, index, item)];
    final bool open = activeIndex.indexOf(key) >= 0;

    // 内容
    children.add(
      AnimatedCrossFade(
        firstChild: Container(),
        secondChild: buildContent(open, index, item.child),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: widget.duration)
      )
    );

    return Column(
      children: children
    );
  }

  renderChildren(list) {
    final List<Widget> children = [];

    // 遍历
    for (int index = 0; index < list.length; index++) {
      final item = list[index];
      final key = item.key == null ? index.toString() : item.key;
      final Widget child = Material(
        color: Colors.white,
        child: buildItem(key, index, item)
      );

      // 判断是否卡片样式
      if (widget.card) {
        children.add(
          Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0.0 : widget.clearance),
            child: child
          )
        );
      } else {
        children.add(border);
        children.add(child);
      }
    }

    // 默认边框
    if (widget.card == false) 
      children.add(border);

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: renderChildren(widget.children)
      )
    );
  }
}

class WeCollapseItem {
  // key
  final String key;
  // 标题
  final Widget title;
  // 内容
  final Widget child;

  WeCollapseItem({
    this.key,
    @required this.title,
    @required this.child
  });
}
