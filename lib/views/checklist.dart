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
    'label': '选项一 - 禁用',
    'value': 1,
    'disabled': true
  },
  {
    'label': '选项二 - 选中禁用',
    'value': 2,
    'disabled': true
  },
  {
    'label': '选项三',
    'value': 3
  },
  {
    'label': '选项四',
    'value': 4
  }
];

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State {
  List value = [];

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Checklist',
      showPadding: false,
      describe: '多选列表',
      child: Column(
        children: <Widget>[
          TextTitle('复选列表项'),
          WeChecklist(
            options: options
          ),
          // 又对齐
          TextTitle('右对齐'),
          WeChecklist(
            align: 'right',
            options: options
          ),
          // 动态改变value
          TextTitle('动态改变value'),
          WeChecklist(
            options: options,
            value: value,
            onChange: (checkedValue) {
              setState(() {
                value = checkedValue;
              });
            }
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: WeButton(
              value.indexOf(2) >= 0 ? '移除第二个' : '选中第二个',
              theme: WeButtonType.primary,
              click: () {
                setState(() {
                  if (value.indexOf(2) >= 0) {
                    value.remove(2);
                  } else {
                    value.add(2);
                  }
                });
              }
            )
          ),
          // 又对齐
          TextTitle('最多选择二个'),
          WeChecklist(
            max: 2,
            options: options
          ),
          // 禁用
          TextTitle('禁用'),
          WeChecklist(
            defaultValue: [2],
            options: options2
          )
        ]
      )
    );
  }
}
