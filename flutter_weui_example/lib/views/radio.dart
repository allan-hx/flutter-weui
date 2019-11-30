import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import '../layout/sample.dart';
import '../components/title.dart';

class RadioPage extends StatefulWidget {
  @override
  RadioPageState createState() => RadioPageState();
}

final Widget child = Row(
  children: [
    Padding(
      padding: EdgeInsets.only(right: 15),
      child: WeRadio(
        value: '1',
        child: Text('选项一'),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 15),
      child: WeRadio(
        value: '2',
        child: Text('选项二'),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 15),
      child: WeRadio(
        value: '3',
        child: Text('选项三'),
      ),
    ),
  ],
);

class RadioPageState extends State {
  String value;

  @override
  Widget build (BuildContext context) {
    return Sample(
      'Radio',
      describe: '单选',
      child: Container(
        child: Column(
          children: <Widget>[
            TextTitle('默认', noPadding: true),
            WeRadioGroup(
              child: child,
            ),
            TextTitle('设置默认值', noPadding: true),
            WeRadioGroup(
              defaultValue: '1',
              child: child,
            ),
            TextTitle('onChange', noPadding: true),
            WeRadioGroup(
              child: child,
              onChange: (value) {
                WeToast.info(context)(value.toString());
              },
            ),
            TextTitle('受控组件', noPadding: true),
            WeRadioGroup(
              value: value,
              onChange: (data) {
                this.setState(() {
                  value = data;
                });
              },
              child: child,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: WeButton('设置第二个选中', onClick: () {
                this.setState(() {
                  value = '2';
                });
              }),
            ),
            TextTitle('禁用', noPadding: true),
            WeRadioGroup(
              defaultValue: '2',
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: WeRadio(
                      value: '1',
                      disabled: true,
                      child: Text('选项一'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: WeRadio(
                      value: '2',
                      disabled: true,
                      child: Text('选项二'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: WeRadio(
                      value: '3',
                      child: Text('选项三'),
                    ),
                  ),
                ],
              )
            ),
          ]
        )
      )
    );
  }
}
