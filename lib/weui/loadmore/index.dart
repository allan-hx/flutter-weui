import 'package:flutter/material.dart';
import '../icon/index.dart';
import '../animation/index.dart';

// 加载中
const Widget _loadingChild = Text('loading...');
// 无数据
const Widget _moreChild = Text('加载更多');
// 边框
final Widget _divider = Expanded(
  flex: 1,
  child: Divider(height: 1.0, color: Color(0xffE5E5E5))
);
// 文字padding
final double _textPadding = 12.0;

class WeLoadmore extends StatefulWidget {
  final bool loading;
  final Widget loadingChild;
  final Widget moreChild;

  WeLoadmore({
    this.loading = false,
    this.loadingChild = _loadingChild,
    this.moreChild = _moreChild
  });

  @override
  WeLoadmoreState createState() => WeLoadmoreState();
}

class WeLoadmoreState extends State<WeLoadmore> {
  @override
  Widget build(BuildContext context) {
    final Widget loadingWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Rotating(Icon(WeIcons.loading, size: 20.0))
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black
          ),
          child: widget.loadingChild
        )
      ]
    );
    
    // moreChild
    final Widget moreChild = Row(
      children: [
        _divider,
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: _textPadding, right: _textPadding),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff808080)
              ),
              child: widget.moreChild
            )
          )
        ),
        _divider
      ]
    );

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: widget.loading ? loadingWidget : moreChild
      )
    );
  }
}
