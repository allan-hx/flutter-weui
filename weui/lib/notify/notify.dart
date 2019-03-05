import 'package:flutter/material.dart';
import 'dart:ui';

class NotifyWidget extends StatefulWidget {
  final Color color;
  final Widget child;

  NotifyWidget({
    key,
    this.color,
    @required this.child
  }) : super(key: key);

  @override
  NotifyWidgetState createState() => NotifyWidgetState();
}

class NotifyWidgetState extends State<NotifyWidget> with TickerProviderStateMixin {
  AnimationController controller;
  //高度动画
  Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  // 初始化动画
  void initAnimation () {
    controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this
    );

    offsetAnimation = Tween<double>(begin: -1, end: 0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease
        )
      )
      ..addListener(() {
        this.setState(() {});
      });
    // 播放
    controller.forward();
  }

  // 反向执行动画
  reverseAnimation() async {
    await controller.reverse();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child:FractionalTranslation(
            translation: Offset(0, offsetAnimation.value),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.color
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQueryData.fromWindow(window).padding.top + 15,
                  bottom: 15,
                  left: 15,
                  right: 15
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                    child: widget.child
                  )
                )
              )
            )
          )
        )
      ]
    );
  }
}
