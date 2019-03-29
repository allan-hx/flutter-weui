import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';
import '../components/title.dart';

class RadioListPage extends StatefulWidget {
  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioListPage> {
  String value;
  final List<WeRadiolistItem> options = [
    WeRadiolistItem(
      label: '选项一',
      value: '1'
    ),
    WeRadiolistItem(
      label: '选项二',
      value: '2'
    ),
    WeRadiolistItem(
      label: '选项三',
      value: '3'
    )
  ];
  final List<WeRadiolistItem> options2 = [
    WeRadiolistItem(
      label: '选项一',
      value: '1'
    ),
    WeRadiolistItem(
      label: '选项二 - 默认选中',
      value: '2'
    ),
    WeRadiolistItem(
      label: '选项三',
      value: '3'
    )
  ];
  final List<WeRadiolistItem> options3 = [
    WeRadiolistItem(
      label: '选项一 禁用',
      value: '1',
      disabled: true
    ),
    WeRadiolistItem(
      label: '选项二 - 默认选中',
      value: '2',
      disabled: true
    ),
    WeRadiolistItem(
      label: '选项二 - 默认选中禁用',
      value: '3'
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Radiolist',
      showPadding: false,
      describe: '单选列表',
      child: Column(
        children: <Widget>[
          TextTitle('单选列表'),
          WeRadiolist(
            children: options
          ),
          TextTitle('默认选中'),
          WeRadiolist(
            children: options2,
            defaultValue: '2'
          ),
          TextTitle('受控组件'),
          WeRadiolist(
            children: options,
            value: value,
            onChange: (checkedValue) {
              setState(() {
                value = checkedValue;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: WeButton(
              '选中第二个',
              theme: WeButtonType.primary,
              onClick: () {
                setState(() {
                  value = '2';
                });
              }
            )
          ),
          TextTitle('禁用'),
          WeRadiolist(
            children: options3,
            defaultValue: '2'
          )
        ]
      )
    );
  }
}
