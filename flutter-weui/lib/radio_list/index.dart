import 'package:flutter/material.dart';
import '../form/index.dart';
import '../cell/index.dart';
import '../icon/index.dart';
import '../theme.dart';
import '../utils.dart';

// onChane
typedef changeBack = void Function(dynamic value);
// icon size
final double _iconSize = 24.0;

class WeRadiolist extends StatefulWidget {
  // 选项
  List<Map<String, Object>> options = [];
  // value
  dynamic value;
  // defaultValue
  dynamic defaultValue;
  // 排列方式
  String align = '';
  // onChange
  changeBack onChange;
  // icon padding间距
  final double padding = 8.0;
  // left padding
  double _leftPadding;
  // right padding
  double _rightPadding;

  WeRadiolist({
    @required this.options,
    this.value,
    this.defaultValue,
    this.align = 'right',
    this.onChange
  }) {
    if (align == 'left') {
      _leftPadding = 0.0;
      _rightPadding = padding;
    } else {
      _leftPadding = padding;
      _rightPadding = 0.0;
    }
  }

  @override
  _RadiolistState createState() => _RadiolistState();
}

class _RadiolistState extends State<WeRadiolist> {
  dynamic checked;

  @override
  void initState() {
    super.initState();
    this.checked = widget.defaultValue;
  }

  dynamic getCheckedValue() {
    return widget.value == null ? checked : widget.value;
  }

  // change
  void change(item) {
    final value = item['value'];
    // 禁用
    if (isTrue(item['disabled'])) return;
    if (widget.value == null) {
      setState(() {
        checked = value;
      });
    }
    // 调用change
    if (widget.onChange is Function) {
      widget.onChange(value);
    }
  }

  Widget renderIcon(item) {
    // 是否选中
    final bool isChecked = getCheckedValue() == item['value'];
    // 配置了禁用或者达到限制
    final bool isDisabled = isTrue(item['disabled']);
    final Color color = Color(0xffc9c9c9);

    return Container(
      width: _iconSize,
      height: _iconSize,
      child: isChecked ? Align(
        alignment: Alignment.center,
        child: Icon(
          WeIcons.hook,
          color: isDisabled ? color : primary,
          size: 18
        )
      ) : null
    );
  }

  List<WeCell> renderList() {
    final List<WeCell> list = [];

    widget.options.forEach((item) {
      List<Widget> children;
      // 图标
      final icon = Padding(
        padding: EdgeInsets.only(left: widget._leftPadding, right: widget._rightPadding),
        child: renderIcon(item)
      );
      // 内容
      final content = Expanded(
        flex: 1,
        child: Container(
          child: Opacity(
            opacity: isTrue(item['disabled']) ? 0.65 : 1.0,
            child: toTextWidget(item['label'], 'label')
          )
        )
      );

      // 排列方式
      if (widget.align == 'left') {
        children = [icon, content];
      } else {
        children = [content, icon];
      }

      list.add(
        WeCell(
          content: Row(
            children: children
          ),
          click: () {
            change(item);
          }
        )
      );
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final formContext = WeForm.of(context);

    return WeCells(
      boxBorder: formContext == null,
      children: renderList()
    );
  }
}
