import 'package:flutter/material.dart';
import '../animation/fade_in.dart';

class Preview extends StatefulWidget {
  // 图片列表
  final List<String> images;
  // 背景色
  final Color color;
  // 遮罩点击
  final Function maskClick;
  // 默认展示
  final int defaultIndex;
  // 指标显示
  final bool indicators;

  Preview({
    key,
    this.images,
    this.color,
    this.maskClick,
    this.defaultIndex,
    this.indicators
  }) : super(key: key);

  @override
  PreviewState createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  GlobalKey fadeInKey = GlobalKey();
  PageController _pageController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.defaultIndex;
    // PageController
    _pageController = PageController(
      initialPage: widget.defaultIndex
    );
  }

  // 反顺动画
  reverseAnimation() async {
    await (fadeInKey.currentState as FadeInState).controller.reverse();
  }

  void onChang(int index) {
    setState(() {
      _index = index;
    });
  }

  // 渲染指标
  Widget renderIndicators() {
    final List<Widget> indicators = [];
    final double size = 7.0;

    for (var i = 0; i < widget.images.length; i++) {
      indicators.add(
        Padding(
          padding: EdgeInsets.only(left: i == 0 ? 0.0 : 7.0),
          child: Opacity(
            opacity: _index == i ? 1.0 : 0.55,
            child: SizedBox(
              width: size,
              height: size,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size)
                  )
                )
              )
            )
          )
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = PageView.builder(
      onPageChanged: onChang,
      controller: _pageController,
      itemCount: widget.images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: widget.maskClick,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              child: Align(
                child: Image.network(widget.images[index])
              )
            )
          )
        );
      }
    );

    // 判断是否显示指标
    if (widget.indicators) {
      child = Stack(
        children: [
          child,
          Positioned(
            right: 0,
            bottom: 20.0,
            left: 0,
            child: renderIndicators()
          )
        ]
      );
    }

    return FadeIn(
      key: fadeInKey,
      duration: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color
        ),
        child: child
      )
    );
  }
}
