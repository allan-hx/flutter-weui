import 'package:flutter/material.dart';
import '../icon/index.dart';

// 默认字体颜色
const Color _fontColor = Color(0xffed6a0c);
// 背景色
const Color _color = Color(0xfffffbe8);

class WeNoticeBar extends StatefulWidget {
  // 字体颜色
  final Color fontColor;
  // 背景色
  final Color color;
  // 图标
  final Widget icon;
  // 动画过度时间
  final int duration;
  // 是否可关闭
  final bool closeable;
  // 内容
  final Widget child;

  WeNoticeBar({
    this.fontColor = _fontColor,
    this.color = _color,
    this.icon,
    this.duration = 15000,
    this.closeable = false,
    @required this.child
  });

  @override
  NoticeBarState createState() => NoticeBarState();
}

class NoticeBarState extends State<WeNoticeBar> with TickerProviderStateMixin {
    // bar容器key
  GlobalKey _barKey = GlobalKey();
  // box
  GlobalKey _boxKey = GlobalKey();
  // padding
  final double _boxPadding = 5.0;
  // 动画
  AnimationController controller;
  Animation transform;
  // 是否被关闭
  bool isClose = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  void init(Duration time) {
    final double _barWidth = _barKey.currentContext.size.width;
    final double _boxWidth = _boxKey.currentContext.size.width;

    // 判断内容和容器的宽度
    if (_barWidth > _boxWidth) {
      controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration),
      );
      transform = Tween<double>(begin: 1, end: -1)
        .animate(controller)
        ..addListener(() {
          setState(() {});
        });
      controller.repeat();
    }
  }

  // 关闭
  void close() {
    disposeAnimate();
    setState(() {
      isClose = true;     
    });
  }

  // 销毁动画
  void disposeAnimate() {
    controller?.dispose();
    controller = null;
  }

  @override
  void dispose() {
    disposeAnimate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isClose) {
      return SizedBox(height: 0.0);
    }

    final List<Widget> children = [
      Expanded(
        key: _boxKey,
        flex: 1,
        child: ClipRect(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Align(
                  key: _barKey,
                  alignment: Alignment.centerLeft,
                  child: FractionalTranslation(
                    translation: Offset(transform == null ? 0 : transform.value, 0),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: widget.fontColor,
                        fontSize: 14.0
                      ),
                      child: widget.child
                    )
                  )
                )
              )
            ]
          )
        )
      )
    ];

    // 判断是否添加图标
    if (widget.icon != null) {
      children.insert(0, Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: widget.icon
      ));
    }

    // 判断是否添加关闭按钮
    if (widget.closeable) {
      children.add(
        GestureDetector(
          onTap: close,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(WeIcons.del, color: widget.fontColor, size: 20.0)
          )
        )
      );
    }

    return SizedBox(
      height: 40.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color
        ),
        child: Padding(
          padding: EdgeInsets.only(left: _boxPadding, right: _boxPadding),
          child: Row(
            children: children
          )
        )
      )
    );
  }
}
