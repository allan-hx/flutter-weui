import 'package:flutter/material.dart';

class Rotating extends StatefulWidget {
  final Widget child;
  final int duration;

  Rotating(this.child, {
    this.duration = 1200
  });

  @override
  RotatingState createState() => RotatingState();
}

class RotatingState extends State<Rotating> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration
      )
    )
    ..repeat();
    animation = Tween(begin: 0.0, end: 360.0)
      .animate(controller)
      ..addListener(() {
        setState(() => null);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: (animation.value ~/ 30) * 30.0 * 0.0174533,
        child: widget.child
      )
    );
  }
}
