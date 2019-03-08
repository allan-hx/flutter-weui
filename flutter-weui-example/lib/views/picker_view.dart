import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';

class PickerViewPage extends StatefulWidget {
  @override
  PickerViewState createState() => PickerViewState();
}

class PickerViewState extends State {
  @override
  Widget build(BuildContext context) {
    final List<WePickerItem> children = [1, 2, 3, 4, 5, 6].map((item) {
      return WePickerItem(
        label: '项选项$item',
        value: '选项$item'
      );
    }).toList();

    return Sample(
      'PickerView',
      describe: '选择器',
      child: Column(
        children: [
          WePickerView(
            itemCount: 5,
            children: [children, children, children]
          )
        ]
      )
    );
  }
}
