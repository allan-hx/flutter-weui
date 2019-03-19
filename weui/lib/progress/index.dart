import 'package:flutter/material.dart';
import '../theme/index.dart';

// box修饰
const BoxDecoration _decoration = BoxDecoration(
  color: Color(0xffEBEBEB)
);

class WeProgress extends StatefulWidget {
  // value值
  final double value;
  // 高度
  final double height;
  // 进度条样式
  final BoxDecoration decoration;
  // 高亮样式
  final BoxDecoration higDecoration;
  // before Widget
  final Widget beforeWidget;
  // before Widget
  final Widget afterWidget;

  WeProgress({
    this.value = 0.0,
    this.height = 4.0,
    this.decoration = _decoration,
    this.higDecoration,
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
  // 高亮样式
  BoxDecoration _higDecoration;

  WeProgressState() {
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 高亮修饰
    _higDecoration = widget.higDecoration == null ? BoxDecoration(
      color: WeUi.getTheme(context).primaryColor
    ) : widget.higDecoration;
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
                width: _curWidth,
                height: widget.height,
                child: DecoratedBox(
                  decoration: _higDecoration
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
