import 'package:flutter/material.dart';
import '../utils.dart';
import './utils.dart';
import '../theme/index.dart';

class IosWidget extends StatefulWidget {
  final dynamic title;
  final bool maskClosable;
  final dynamic cancelButton;
  final Function() close;
  final Function(int index) onChange;
  final List<dynamic> childer;

  IosWidget({
    key,
    this.title,
    this.maskClosable,
    this.cancelButton,
    this.close,
    this.onChange,
    this.childer
  }) : super(key: key);

  @override
  IosWidgetState createState() => IosWidgetState();
}

class IosWidgetState extends State<IosWidget> with TickerProviderStateMixin {
  final GlobalKey _boxKey = GlobalKey();
  // 容器高度
  double _boxHeight = 0;
  // 是否是取消
  int _index;
  // 动画
  AnimationController _controller;
  //高度动画
  Animation<double> top;
  // 高度
  Animation<double> opacity;
  // 主题
  WeTheme theme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this
    );
    WidgetsBinding.instance.addPostFrameCallback(getBoxHeight);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = WeUi.getTheme(context);
  }

  // 获取容器高度
  void getBoxHeight(Duration time) {
    _boxHeight = _boxKey.currentContext.size.width;
    createAnimate();
    startAnimate();
  }

  // 创建动画
  void createAnimate() {
    // 内容动画
    top = Tween<double>(begin: _boxHeight, end: 0)
      .animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.decelerate
        )
      )
      ..addStatusListener(animateEnd);

    // 遮罩层透明动画
    opacity = Tween<double>(begin: 0.0, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.decelerate
        )
      );
  }

  // 开始动画
  void startAnimate() {
    _controller.forward();
  }

  // 动画结束
  void animateEnd(state) {
    if (state == AnimationStatus.dismissed) {
      if (_index == null) {
        widget.close();
      } else {
        widget.onChange(_index);
      }
      // 销毁
      _controller.dispose();
    }
  }

  // 取消
  void close() {
    _index = null;
    _controller.reverse();
  }

  // item click
  void itemClick(int index) {
    _index = index;
    _controller.reverse();
  }

  // 渲染title
  Widget renderTitle() {
    return SizedBox(
      height: 50.0,
      child: Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w500
          ),
          child: toTextWidget(widget.title, 'title')
        )
      )
    );
  }

  // 取消按钮
  Widget renderCancelButton() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: close,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 6.0, color: Color(0xffEFEFF4)))
          ),
          child: SizedBox(
            height: 55.0,
            child: Align(
              alignment: Alignment.center,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
                child: toTextWidget(widget.cancelButton, 'cancelButton')
              )
            )
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // list
    final List<Widget> list = [];

    // 判断标题
    if (widget.title != null) {
      list.add(renderTitle());
      list.add(Divider(height: 1, color: theme.defaultBorderColor));
    }

    // 选项
    list.addAll(initChilder(widget.childer, itemClick, theme.defaultBorderColor));

    // 取消按钮
    if (widget.cancelButton != null) {
      list.add(renderCancelButton());
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: <Widget>[
            // 遮罩层
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.maskClosable) close();
                },
                child: Opacity(
                  opacity: opacity == null ? 0.0 : opacity.value,
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.maskColor
                      )
                    )
                  )
                )
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Transform.translate(
                offset: Offset(0, top == null ? 10000.0 : top.value),
                child: DecoratedBox(
                  key: _boxKey,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Material(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: list
                    )
                  )
                )
              )
            )
          ]
        );
      }
    );
  }
}
