import 'package:flutter/material.dart';
import '../animation/fade_in.dart';

class InfoWidget extends StatelessWidget {
  // 内容
  final Widget message;
  // 位置
  final String align;
  // 距离
  final double distance;

  InfoWidget(this.message, {
    this.align,
    this.distance
  });

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    // info内容
    Widget infoWidget = FadeIn(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(17, 17, 17, 0.7),
          borderRadius: BorderRadius.all(Radius.circular(4.0))
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 6.0,
            right: 18.0,
            bottom: 6.0,
            left: 18.0
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            ),
            child: message
          )
        )
      )
    );
    
    // 判断对齐方式
    switch(align) {
      case 'top':
        alignment = Alignment.topCenter;
        infoWidget = Padding(
          padding: EdgeInsets.only(top: distance),
          child: infoWidget
        );
        break;
      case 'bottom':
        alignment = Alignment.bottomCenter;
        infoWidget = Padding(
          padding: EdgeInsets.only(bottom: distance),
          child: infoWidget
        );
        break;
      default:
        alignment = Alignment.center;
        break;
    }

    return Align(
      alignment: alignment,
      child: infoWidget
    );
  }
}
