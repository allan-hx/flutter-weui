import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final bool noPadding;

  TextTitle(this.title, { this.noPadding = false });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: noPadding ? EdgeInsets.only(top: 30.0, bottom: 8.0) : EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(title, style: TextStyle(
          fontSize: 16
        ))
      )
    );
  }
}
