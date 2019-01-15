import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';
import '../components/title.dart';

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State {
  List<String> value = [];
  final List<WeChecklistItem> options = [
    WeChecklistItem(
      label: '选项一',
      value: '1'
    ),
    WeChecklistItem(
      label: '选项二',
      value: '2'
    ),
    WeChecklistItem(
      label: '选项三',
      value: '3'
    )
  ];
  final List<WeChecklistItem> options2 = [
    WeChecklistItem(
      label: '选项一 - 禁用',
      value: '1',
      disabled: true
    ),
    WeChecklistItem(
      label: '选项二 - 选中禁用',
      value: '2'
    ),
    WeChecklistItem(
      label: '选项三',
      value: '3'
    ),
    WeChecklistItem(
      label: '选项四',
      value: '4'
    )
  ];

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
            children: options
          ),
          // 又对齐
          TextTitle('右对齐'),
          WeChecklist(
            align: 'right',
            children: options
          ),
          // 动态改变value
          TextTitle('动态改变value'),
          WeChecklist(
            children: options,
            value: value,
            onChange: (checkedValue) {
              print(checkedValue);
              setState(() {
                value = checkedValue;
              });
            }
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: WeButton(
              value.indexOf('2') >= 0 ? '移除第二个' : '选中第二个',
              theme: WeButtonType.primary,
              onClick: () {
                setState(() {
                  if (value.indexOf('2') >= 0) {
                    value.remove('2');
                  } else {
                    value.add('2');
                  }
                });
              }
            )
          ),
          // 又对齐
          TextTitle('最多选择二个'),
          WeChecklist(
            max: 2,
            children: options
          ),
          // 禁用
          TextTitle('禁用'),
          WeChecklist(
            defaultValue: ['2'],
            children: options2
          )
        ]
      )
    );
  }
}
