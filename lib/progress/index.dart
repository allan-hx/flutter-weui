import 'package:flutter/material.dart';
import '../theme.dart';

// box修饰
const BoxDecoration _decoration = BoxDecoration(
  color: Color(0xffEBEBEB)
);
// 高亮修饰
const BoxDecoration _higDecoration = BoxDecoration(
  color: primary
);

class WeProgress extends StatefulWidget {
  // value值
  final double value;
  // 高度
  final double height;
  // 进度条
  final BoxDecoration decoration;
  // 高亮
  final BoxDecoration higDecoration;
  // before Widget
  final Widget beforeWidget;
  // before Widget
  final Widget afterWidget;

  WeProgress({
    this.value = 0.0,
    this.height = 4.0,
    this.decoration = _decoration,
    this.higDecoration = _higDecoration,
    this.beforeWidget,
    this.afterWidget
  });

  @override
  WeProgressState createState() => WeProgressState();
}

class WeProgressState extends State<WeProgress> with SingleTickerProviderStateMixin  {
  final GlobalKey _boxKey = GlobalKey();
  double _boxWidth = 0.0;
  double _curWidth = 0;
  // AnimationController _controller;
  // Animation<double> _animation;

  WeProgressState() {
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  void init(time) {
    setState(() {
      _boxWidth = _boxKey.currentContext.size.width;  
    });
  }

  @override
  void didUpdateWidget(WeProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _curWidth = (widget.value / 100) * _boxWidth;
    }
  }

  // void createAnimation(double begin, double end) {
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(
  //       milliseconds: 400
  //     )
  //   );
  //   _animation = Tween(begin: begin, end: end)
  //     .animate(_controller)
  //     ..addListener((){
  //       setState(() => null);
  //     });
  //   _controller.forward();
  // }

  @override
  Widget build(BuildContext context) {
    final Widget barWidget = SizedBox(
      key: _boxKey,
      height: widget.height,
      child: DecoratedBox(
        decoration: widget.decoration,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                // width: _animation == null ? 0.0 : _animation.value,
                width: _curWidth,
                height: widget.height,
                child: DecoratedBox(
                  decoration: widget.higDecoration
                )
              )
            )
          ]
        )
      )
    );

    if (widget.afterWidget != null || widget.beforeWidget != null) {
      final List<Widget> children = [
        Expanded(
          flex: 1,
          child: barWidget
        )
      ];

      if (widget.beforeWidget is Widget) {
        children.insert(0, widget.beforeWidget);
      }

      if (widget.afterWidget is Widget) {
        children.add(widget.afterWidget);
      }

      return Row(
        children: children
      );
    }

    return barWidget;
  }
}
