import 'package:flutter/material.dart';
import '../theme/index.dart';
import '../icon/index.dart';

class WeRadioGroup<T> extends StatefulWidget {
  // 默认值
  final T defaultValue;
  // 当前值
  final T value;
  // 点击时触发
  final void Function(T data) onChange;
  // 内容
  final Widget child;

  WeRadioGroup({
    this.defaultValue,
    this.value,
    this.onChange,
    @required this.child
  });

  @override
  WeRadioGroupState createState() => WeRadioGroupState<T>();
}

class WeRadioGroupState<T> extends State<WeRadioGroup> {
  T value;

  @override
  void initState() {
    super.initState();
    // 非受控组件才能使用defaultValue，受控组件直接使用value控制
    value = widget.value == null ? widget.defaultValue : widget.value;
  }

  @override
  void didUpdateWidget(WeRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      this.setState(() {
        value = widget.value;
      });
    }
  }

  void onChange(T id) {
    this.setState(() {
      value = id;
    });

    // 调用onChange
    if (widget.onChange is Function) widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroupScope(
      radioGroup: this,
      child: widget.child,
    );
  }
}

class WeRadio<T> extends StatefulWidget {
  // 禁用状态
  final bool disabled;
  // 选中的value
  final T value;
  // 内容
  final Widget child;

  WeRadio({
    this.disabled = false,
    @required this.value,
    @required this.child,
  });

  @override
  WeRadioState createState() => WeRadioState();
}

class WeRadioState extends State<WeRadio> {
  bool isChecked = false;
  final double _iconBoxSize = 18;

  void toggleChecked() {
    final RadioGroupScope group = RadioGroupScope.of(context);
    group.radioGroup.onChange(widget.value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final RadioGroupScope group = RadioGroupScope.of(context);
    isChecked = group.radioGroup.value == widget.value;
  }

  Map<String, Color> _getColor() {
    final WeTheme theme = WeUi.getTheme(context);

    if (widget.disabled) {
      return {
        'borderColor': Color(0xffd8d8d8),
        'bgColor': Color(0xfff8f8f8)
      };
    } else if (isChecked) {
      return {
        'borderColor': theme.primaryColor,
        'bgColor': theme.primaryColor
      };
    } else {
      return {
        'borderColor': theme.defaultBorderColor,
        'bgColor': Colors.white
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colors = _getColor();

    final Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors['bgColor'],
                border: Border.all(width: 1, color: colors['borderColor']),
                borderRadius: BorderRadius.all(Radius.circular(_iconBoxSize / 2)),
              ),
              child: SizedBox(
                width: _iconBoxSize,
                height: _iconBoxSize
              ),
            ),
            Positioned(
              top: 1.4,
              right: 0,
              left: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform.scale(
                  scale: isChecked ? 1 : 0,
                  child: Icon(WeIcons.hook, size: 14, color: widget.disabled ? Color(0xffd8d8d8) : Colors.white)
                )
              )
            )
          ]
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 6),
              child: widget.child
            )
          )
        )
      ]
    );

    // 判断是否禁用
    if (widget.disabled) {
      return child;
    }

    return GestureDetector(
      onTap: toggleChecked,
      child: child
    );
  }
}

class RadioGroupScope extends InheritedWidget {
  final WeRadioGroupState radioGroup;

  RadioGroupScope({
    Key key,
    child,
    this.radioGroup,
  }) : super(key: key, child: child);

  static RadioGroupScope of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RadioGroupScope);
  }

  @override
  bool updateShouldNotify(RadioGroupScope oldWidget) {
    return true;
  }
}
