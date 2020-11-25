import 'package:flutter/material.dart';
import '../animation/fade_in.dart';
import '../theme/index.dart';

// 方向
enum WeDrawerPlacement {
  top,
  right,
  bottom,
  left
}

class DrawerWidget extends StatefulWidget {
  final WeDrawerPlacement placement;
  final Widget child;
  final bool mask;
  final Function() maskClick;
  final int duration;
  final Color background;

  DrawerWidget({
    key,
    this.placement,
    this.mask,
    this.maskClick,
    this.duration = 150,
    this.background,
    @required this.child
  }) : super(key: key);

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> with TickerProviderStateMixin<DrawerWidget> {
  GlobalKey boxKey = GlobalKey();
  AnimationController controller;
  //高度动画
  Animation<double> offsetAnimation;
  // 是否垂直
  bool isVertical;
  WeTheme theme;

  @override
  void initState() {
    super.initState();
    // 判断方向
    isVertical = [WeDrawerPlacement.top, WeDrawerPlacement.bottom].indexOf(widget.placement) >= 0;

    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this
    );

    offsetAnimation = Tween<double>(begin: 2000, end: 0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease
        )
      );

    WidgetsBinding.instance.addPostFrameCallback(getBoxHeight);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = WeUi.getTheme(context);
  }

  void getBoxHeight(Duration time) {
    initAnimation();
  }

  // 反向执行动画
  reverseAnimation() async {
    await controller.reverse();
  }

  // 初始化动画
  void initAnimation() {
    final double size = isVertical ? boxKey.currentContext.size.height : boxKey.currentContext.size.width;

    double begin;
    // 方向判断
    switch (widget.placement) {
      case WeDrawerPlacement.top:
      case WeDrawerPlacement.left:
        begin = -size;
        break;
      case WeDrawerPlacement.right:
      case WeDrawerPlacement.bottom:
        begin = size;
        break;
    }

    offsetAnimation = Tween<double>(begin: begin, end: 0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease
        )
      );
    // 播放动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Offset offset;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    double left = 0.0;

    // 判断方向
    switch (widget.placement) {
      case WeDrawerPlacement.top:
        bottom = null;
        break;
      case WeDrawerPlacement.right:
        left = null;
        break;
      case WeDrawerPlacement.bottom:
        top = null;
        break;
      case WeDrawerPlacement.left:
        right = null;
        break;
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        // 方向
        if (isVertical) {
          offset = Offset(0, offsetAnimation.value);
        } else {
          offset = Offset(offsetAnimation.value, 0);
        }

        final List<Widget> children = [
          Positioned(
            top: top,
            right: right,
            bottom: bottom,
            left: left,
            child: Transform.translate(
              offset: offset,
              child: DecoratedBox(
                key: boxKey,
                decoration: BoxDecoration(
                  color: widget.background ?? Colors.white,
                ),
                child: widget.child
              )
            )
          )
        ];

        // 判断是否添加遮罩
        if (widget.mask) {
          children.insert(0, Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: FadeIn(
              autoPlay: false,
              controller: controller,
              child: GestureDetector(
                onTap: widget.maskClick,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.maskColor
                  )
                )
              )
            )
          ));
        }

        return Stack(
          children: children
        );
      }
    );
  }
}
