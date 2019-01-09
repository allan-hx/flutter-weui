import 'package:flutter/material.dart';

class Scale extends StatefulWidget {
  final Widget child;
  final bool autoPlay;
  final int duration;
  final double begin;
  final double end;

  Scale({
    key,
    @required this.child,
    this.autoPlay = true,
    this.duration = 150,
    this.begin = 0.0,
    this.end = 1.0
  }) : super(key: key);

  @override
  ScaleState createState() => ScaleState();
}

class ScaleState extends State<Scale> with TickerProviderStateMixin {
  AnimationController controller;
  Animation transform;

  @override
  void initState() {
    super.initState();
    createAnimate();
  }

  // 创建动画
  void createAnimate() {
    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this
    );

    // 内容放大动画
    transform = Tween<double>(begin: widget.begin, end: widget.end)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease
        )
      );
  
    if (widget.autoPlay) controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: transform.value,
          child: widget.child
        );
      }
    );
  }
}
