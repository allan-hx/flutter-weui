import 'package:flutter/material.dart';
import '../cell/index.dart';
import '../utils.dart';
import '../icon/index.dart';

class WeInput extends StatefulWidget {
  // key
  final GlobalKey key;
  // label
  dynamic label;
  // 默认值
  final String defaultValue;
  // 最大行数
  final int maxLines;
  // 提示文字
  final String hintText;
  // footer
  final Widget footer;
  // 是否显示清除
  bool clearable;
  // 文字对其方式
  final TextAlign textAlign;
  // 输入框类型
  final TextInputType type;
  // 密码框
  final bool obscureText;
  // 样式
  final TextStyle style;
  // 是否自动获取光标
  final bool autofocus;
  // label宽度
  final double labelWidth;
  // onChange
  final Function(String value) onChange;

  WeInput({
    label,
    this.key,
    this.defaultValue = '',
    this.maxLines = 1,
    this.hintText,
    this.footer,
    this.clearable = false,
    this.textAlign = TextAlign.start,
    this.type = TextInputType.text,
    this.obscureText = false,
    this.style,
    this.autofocus = false,
    this.labelWidth = 80.0,
    this.onChange
  }) : this.label = toTextWidget(label, 'label'),
      super(key: key);

  @override
  WeInputState createState() => WeInputState();
}

class WeInputState extends State<WeInput> {
  final TextEditingController controller = TextEditingController();

  WeInputState() {
    _init();
  }

  // 初始化
  _init() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) {
      _setValue(widget.defaultValue);
    });
  }

  // 清除value
  void _clearValue() {
    _setValue('');
  }

  // 输入框onChange
  void _onChange(String value) {
    if (widget.onChange is Function) {
      widget.onChange(value);
    }
    setState(() {});
  }

  void _setValue(value) {
    setState(() {
      controller.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 清除按钮
    final Widget clearWidget = GestureDetector(
      onTap: _clearValue,
      child: Container(
        child: Icon(
          WeIcons.clear,
          color: Color(0xffc8c9cc),
          size: 25.0
        )
      )
    );

    // label
    Widget label;
    if (widget.label is Widget) {
      label = Container(
        width: widget.labelWidth,
        child: widget.label
      );
    }

    // footer
    Widget footer;
    if (widget.clearable) {
      footer = controller.text.length > 0 ? clearWidget : null;
    } else {
      footer = widget.footer;
    }

    return WeCell(
      // label
      label: label,
      footer: footer,
      content: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
        ),
        child: TextField(
          autofocus: widget.autofocus,
          textAlign: widget.textAlign,
          keyboardType: widget.type,
          obscureText: widget.obscureText,
          style: widget.style,
          controller: controller,
          onChanged: _onChange,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText
          )
        )
      )
    );
  }
}
