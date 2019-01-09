import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:flutter_weui/flutter_weui.dart';

class Loadmore extends StatefulWidget {
  @override
  LoadmorePageState createState() => LoadmorePageState();
}

class LoadmorePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Sample(
      'Loadmore',
      describe: '加载中',
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WeLoadmore(
            loading: true,
            loadingChild: Text('加载中...')
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0)
          ),
          WeLoadmore(
            moreChild: Text('加载更多...')
          )
        ]
      )
    );
  }
}