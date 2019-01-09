import 'package:flutter/material.dart';
import '../layout/sample.dart';
import '../weui/index.dart';
import '../components/title.dart';

const options = [
  {
    'label': '选项一',
    'value': 1
  },
  {
    'label': '选项二',
    'value': 2
  },
  {
    'label': '选项三',
    'value': 3
  }
];


const options2 = [
  {
    'label': '选项一',
    'value': 1
  },
  {
    'label': '选项二 - 默认选中',
    'value': 2
  },
  {
    'label': '选项三',
    'value': 3
  }
];

const options3 = [
  {
    'label': '选项一 禁用',
    'value': 1,
    'disabled': true
  },
  {
    'label': '选项二 - 默认选中禁用',
    'value': 2,
    'disabled': true
  },
  {
    'label': '选项三',
    'value': 3
  }
];

class RadioListPage extends StatefulWidget {
  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioListPage> {
  int value;

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
            options: options
          ),
          TextTitle('默认选中'),
          WeRadiolist(
            options: options2,
            defaultValue: 2
          ),
          TextTitle('动态改变value'),
          WeRadiolist(
            options: options,
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
              click: () {
                setState(() {
                  value = 2;
                });
              }
            )
          ),
          TextTitle('禁用'),
          WeRadiolist(
            options: options3,
            defaultValue: 2
          )
        ]
      )
    );
  }
}