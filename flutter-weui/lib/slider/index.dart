import 'package:flutter/material.dart';
import '../theme.dart';

// 默认背景
const Color defaultColor = Color(0xffE9E9E9);
// onChange
typedef onChangeBack = void Function(dynamic value);

class WeSlider extends StatefulWidget {
  final int value;
  // 默认值
  final int defaultValue;
  // 默认颜色
  final Color color;
  // 高亮色
  final Color higColor;
  // 进度条高度
  final double height;
  // 按钮大小
  final double buttonSize;
  // 最大值
  final int max;
  // 最小值
  final int min;
  // step
  final int step;
  // 禁用状态
  final bool disabled;
  // onChange
  final onChangeBack onChange;

  WeSlider({
    this.value,
    this.defaultValue = 0,
    this.color = defaultColor,
    this.higColor = primary,
    this.height = 2.0,
    this.buttonSize = 26.0,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.disabled = false,
    this.onChange
  });

  @override
  _WeSliderState createState() => _WeSliderState(max / step, defaultValue);
}

class _WeSliderState extends State<WeSlider> {
  // max value
  double _max;
  // start x
  double _startX = 0.0;
  // end x
  double _startLeft = 0.0;
  // 容器宽度
  double _boxWidth;
  // 一步宽度
  double _stepWidth = 0.0;
  // 按钮宽度
  double _buttonWidth;
  // 按钮 key
  GlobalKey _buttonKey = new GlobalKey();
  // 容器 key
  GlobalKey _boxKey = new GlobalKey();
  int _value = 0;

  _WeSliderState(this._max, defaultValue) {
    _value = defaultValue;
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  // 按下
  void touchStart(data) {
    setStartLeft();
    _startX = data.globalPosition.dx;
  }

  // 拖动
  void touchMove(data) {
    final double max = _boxWidth;
    // icon 移动的值
    double moveLeft = _startLeft + (data.globalPosition.dx - _startX);

    // 边界值判断
    if (moveLeft <= 0) {
      moveLeft = 0;
    } else if (moveLeft >= max) {
      moveLeft = max;
    }

    // 当前value
    final curProportion = moveLeft / max;
    final value = int.parse((curProportion * _max).toStringAsFixed(0));

    // 截流
    if (_value == value) return;

    setState(() {
      _value = value;
    });

    // onChange
    if (widget.onChange is Function) {
      widget.onChange(value * widget.step);
    }
  }

  void setStartLeft() {
    _startLeft = (widget.value is int ? widget.value : _value) * _stepWidth;
  }

  void init(Duration timeStamp) {
    setState(() {
      // 获取按钮宽度
      _buttonWidth = _buttonKey.currentContext.size.width;
      // 获取box宽度
      _boxWidth = _boxKey.currentContext.size.width - _buttonWidth;
      // 计算一步的宽度
      _stepWidth = _boxWidth / _max;
      // 默认值
      if (widget.step != 1) {
        _value = int.parse((_value / widget.step).toStringAsFixed(0));
      }
      setStartLeft();
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = (widget.value is int ? widget.value : _value) * _stepWidth;

    return SizedBox(
      key: _boxKey,
      height: widget.buttonSize,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              height: widget.height,
              color: widget.color
            )
          ),
          // slider bar
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              height: widget.buttonSize,
                child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: value,
                  height: widget.height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widget.higColor
                    )
                  )
                )
              )
            )
          ),
          // button icon
          Positioned(
            left: value,
            top: 0,
            child: GestureDetector(
              // start
              onHorizontalDragStart: touchStart,
              // move
              onHorizontalDragUpdate: touchMove,
              child: Container(
                key: _buttonKey,
                width: widget.buttonSize,
                height: widget.buttonSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(widget.buttonSize)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffebebeb),
                      blurRadius: 2.0,
                      spreadRadius: 2.5,
                      offset: Offset(0, 0)
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }
}
