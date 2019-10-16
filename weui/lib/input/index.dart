import 'package:flutter/material.dart';
import '../cell/index.dart';
import '../utils.dart';
import '../icon/index.dart';

class WeInput extends StatefulWidget {
  // key
  final Key key;
  // label
  final dynamic label;
  // 高度
  final double height;
  // 默认值
  final String defaultValue;
  // 最大行数
  final int maxLines;
  // 限制输入数量
  final int maxLength;
  // 提示文字
  final String hintText;
  // 光标
  final FocusNode focusNode;
  // footer
  final Widget footer;
  // 是否显示清除
  final bool clearable;
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
  // TextInputAction
  final TextInputAction textInputAction;
  // onChange
  final Function(String value) onChange;

  WeInput({
    this.key,
    label,
    this.height = 48,
    this.defaultValue = '',
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.focusNode,
    this.footer,
    this.clearable = false,
    this.textAlign = TextAlign.start,
    this.type = TextInputType.text,
    this.obscureText = false,
    this.style,
    this.autofocus = false,
    this.labelWidth = 80.0,
    this.textInputAction,
    this.onChange
  }) : this.label = toTextWidget(label, 'label'),
      super(key: key);

  @override
  WeInputState createState() => WeInputState();
}

class WeInputState extends State<WeInput> {
  final TextEditingController controller = TextEditingController();
  TextInputAction textInputAction;

  WeInputState() {
    _init();
  }

  @override
  void initState() {
    super.initState();
    if (widget.textInputAction == null) {
      textInputAction = widget.maxLines == 1 ? TextInputAction.search : TextInputAction.newline;
    } else {
      textInputAction = widget.textInputAction;
    }
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
    if (widget.onChange is Function) {
      widget.onChange('');
    }
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
      minHeight: widget.height,
      content: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
        ),
        child: TextField(
          autofocus: widget.autofocus,
          textAlign: widget.textAlign,
          keyboardType: widget.type,
          textInputAction: textInputAction,
          obscureText: widget.obscureText,
          style: widget.style,
          controller: controller,
          focusNode: widget.focusNode,
          onChanged: _onChange,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            counterText: ''
          )
        )
      )
    );
  }
}
