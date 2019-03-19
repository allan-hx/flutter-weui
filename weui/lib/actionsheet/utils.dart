import 'package:flutter/material.dart';
import './index.dart';
import '../utils.dart';

final double _leftPadding = 18.0;
final double _topPadding = 12.0;

List<Widget> initChilder(List<WeActionsheetItem> childer, onChange, Color borderColor, { Alignment align = Alignment.center }) {
  // 列表
  final List<Widget> list = [];

  // 循环childer
  for (int index = 0; index < childer.length; index++) {
    // 边框
    if (index != 0) {
      list.add(Divider(height: 1, color: borderColor));
    }

    list.add(
      InkWell(
        onTap: () {
          onChange(index);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Align(
            alignment: align,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                  top: _topPadding,
                  right: _leftPadding,
                  bottom: _topPadding,
                  left: _leftPadding
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                  ),
                  child: toTextWidget(childer[index].label, 'childer中的值')
                )
              )
            )
          )
        )
      )
    );
  }

  return list;
}