import 'package:flutter/material.dart';
import '../cell/index.dart';

class WeForm extends StatefulWidget {
  final List<Widget> children;

  WeForm({
    key,
    @required this.children
  }) : super(key: key);

  static WeFormState of(BuildContext context) {
    final WeFormScope scope = context.inheritFromWidgetOfExactType(WeFormScope);
    return scope?.state;
  }

  @override
  WeFormState createState() => WeFormState();
}

class WeFormState extends State<WeForm> {
  final Map<dynamic, dynamic> formValue = {};

  // 设置表单值
  void setValue(Map<dynamic, dynamic> value) {
    setState(() {
      formValue.addAll(value);
    });
  }

  validate() {
    print(formValue);
  }

  @override
  Widget build(BuildContext context) {
    return WeFormScope(
      state: this,
      formValue: formValue,
      child: WeCells(
        children: widget.children
      )
    );
  }
}

class WeFormScope extends InheritedWidget {
  final WeFormState state;
  final formValue;

  WeFormScope({
    Key key,
    this.state,
    this.formValue,
    Widget child
  }) : super(key: key, child: child);

  static WeFormScope of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(WeFormScope);
  }

  //是否重建widget就取决于数据是否相同
  @override
  bool updateShouldNotify(WeFormScope oldWidget) {
    return formValue != oldWidget.formValue;
  }
}
