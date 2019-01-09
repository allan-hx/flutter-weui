import 'package:flutter/material.dart';
import '../layout/sample.dart';
import '../weui/index.dart';
import '../components/title.dart';
// import '../weui/theme.dart';

class SwipePage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
}

class SwipePageState extends State {
  final GlobalKey swipeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];
    [1, 2, 3, 4].forEach((int item) {
      list.add(
        Container(
          color: item % 2 == 0 ? Color(0xff39a9ed) : Color(0xff66c6f2),
          child: Align(
            alignment: Alignment.center,
            child: Text(item.toString(), style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            ))
          )
        )
      );
    });

    return Sample(
      'Swipe',
      describe: '轮播',
      child: Column(
        children: <Widget>[
          TextTitle('默认', noPadding: true),
          WeSwipe(
            height: 150.0,
            children: list
          ),
          TextTitle('隐藏indicators', noPadding: true),
          WeSwipe(
            height: 150.0,
            indicators: false,
            children: list
          ),
          TextTitle('禁止循环', noPadding: true),
          WeSwipe(
            height: 150.0,
            cycle: false,
            children: list
          ),
          TextTitle('禁止自动播放', noPadding: true),
          WeSwipe(
            height: 150.0,
            autoPlay: false,
            children: list
          ),
          TextTitle('默认展示第二页', noPadding: true),
          WeSwipe(
            height: 150.0,
            defaultIndex: 1,
            children: list
          ),
          TextTitle('手动切换到指定页', noPadding: true),
          WeSwipe(
            key: swipeKey,
            height: 150.0,
            children: list
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: WeButton(
              '外部控制',
              theme: WeButtonType.primary,
              click: () {
                (swipeKey.currentState as WeSwipeState).setIndex(2);
              }
            )
          ),
          TextTitle('自定义高度', noPadding: true),
          WeSwipe(
            height: 250.0,
            children: list
          )
        ]
      )
    );
  }
}
