import 'package:flutter/material.dart';
import '../theme/index.dart';
import './utils.dart';

class AndroidWidget extends StatefulWidget {
  final bool maskClosable;
  final Function() close;
  final Function(int index) onChange;
  final List<dynamic> childer;

  AndroidWidget({
    key,
    this.maskClosable,
    this.close,
    this.onChange,
    this.childer
  }) : super(key: key);

  @override
  AndroidWidgetState createState() => AndroidWidgetState();
}

class AndroidWidgetState extends State<AndroidWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int _index;
  WeTheme theme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200
      )
    );
    _animation = Tween(begin: 0.0, end: 1.0)
      .animate(_controller)
      ..addListener(() {
        setState(() => null);
      })
      ..addStatusListener(animateListener);

    // 播放
    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = WeUi.getTheme(context);
  }

  // 动画监听
  animateListener(state) {
    if (state == AnimationStatus.dismissed) {
      if (_index == null) {
        widget.close();
      } else {
        widget.onChange(_index);
      }
    }
  }

  // 遮罩层点击
  void close() {
    _index = null;
    _controller.reverse();
  }

  // 选项点击
  void itemClick(int index) {
    _index = index;
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: GestureDetector(
        onTap: () {
          if (widget.maskClosable) close();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.maskColor
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 55.0, right: 55.0),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: initChilder(widget.childer, itemClick, theme.defaultBorderColor, align: Alignment.centerLeft)
                )
              )
            )
          )
        )
      )
    );
  }
}
