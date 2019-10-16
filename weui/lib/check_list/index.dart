import 'package:flutter/material.dart';
import '../form/index.dart';
import '../cell/index.dart';
import '../icon/index.dart';
import '../theme/index.dart';
import '../utils.dart';

// onChane
typedef OnChangeBack = void Function(List<String> value);

// icon size
final double _iconSize = 22.0;

class WeChecklist extends StatefulWidget {
  // 选项
  final List<WeChecklistItem> children;
  // value
  final List<String> value;
  // 默认选中
  final List<String> defaultValue;
  // 排列方式
  final String align;
  // onChange
  final OnChangeBack onChange;
  // max
  final int max;
  // icon padding间距
  final double padding = 8.0;
  // left padding
  double _leftPadding;
  // right padding
  double _rightPadding;

  WeChecklist({
    @required this.children,
    this.value,
    this.defaultValue,
    this.align = 'left',
    this.onChange,
    max
  }): this.max = max is int ? max : children.length {
    if (align == 'left') {
      _leftPadding = 0.0;
      _rightPadding = padding;
    } else {
      _leftPadding = padding;
      _rightPadding = 0.0;
    }
  }

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<WeChecklist> {
  List<String> checkedList = [];
  WeTheme theme;

  @override
  void initState() {
    super.initState();
    this.checkedList = widget.defaultValue == null ? [] : widget.defaultValue;
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    theme = WeUi.getTheme(context);
  }

  List<String> getCheckedValue() {
    return widget.value == null ? checkedList : widget.value;
  }

  // change
  void change(item) {
    final value = item.value;
    List<String> checkedList = getCheckedValue();
    // 判断是否选中
    if (checkedList.indexOf(value) >= 0) {
      checkedList.remove(value);
    } else {
      // 限制最大选择
      if (checkedList.length == widget.max) return;
      checkedList.add(value);
    }
    // 更新
    if (widget.value == null) {
      setState(() {});
    }
    // 调用change
    if (widget.onChange is Function) {
      widget.onChange(checkedList);
    }
  }

  Widget renderIcon(item) {
    List<String> checkedList = getCheckedValue();
    // 是否选中
    final bool isChecked = checkedList.indexOf(item.value) >= 0;
    // 配置了禁用或者达到限制
    final bool isDisabled = isTrue(item.disabled) || (checkedList.length == widget.max && !isChecked);
    Color borderColor;
    Color bgColor;

    // 判断是否禁用
    if (isDisabled) {
      borderColor = bgColor = theme.defaultBorderColor;
    } else if (isChecked) {
      borderColor = bgColor = theme.primaryColor;
    } else {
      borderColor = theme.defaultBorderColor;
      bgColor = Colors.transparent;
    }

    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(width: 1, color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(_iconSize))
      ),
      child: isChecked ? Align(
        alignment: Alignment.center,
        child: Icon(
          WeIcons.hook,
          color: Colors.white,
          size: 16
        )
      ) : null
    );
  }

  List<WeCell> renderList() {
    return widget.children.map((item) {
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
            opacity: isTrue(item.disabled) ? 0.65 : 1.0,
            child: toTextWidget(item.label, 'label')
          )
        )
      );

      // 排列方式
      if (widget.align == 'left') {
        children = [icon, content];
      } else {
        children = [content, icon];
      }

      return WeCell(
        content: Row(
          children: children
        ),
        onClick: item.disabled ? null : () {
          change(item);
        }
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final formContext = WeForm.of(context);

    // 判断是否有form包裹
    return WeCells(
      boxBorder: formContext == null,
      children: renderList()
    );
  }
}

class WeChecklistItem {
  final dynamic label;
  final String value;
  final bool disabled;

  WeChecklistItem({
    @required this.label,
    @required this.value,
    this.disabled = false
  });
}
