import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils.dart';

// 边框
final Divider border = Divider(height: 1, color: defaultBorderColor);
final double _leftPadding = 18.0;
final double _topPadding = 12.0;

List<Widget> initChilder(List<Widget> childer, onChange, { Alignment align = Alignment.center }) {
  // 列表
  final List<Widget> list = [];

  // 循环childer
  for (int index = 0; index < childer.length; index++) {
    // 边框
    if (index != 0) {
      list.add(border);
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
                  child: toTextWidget(childer[index], 'childer中的值')
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