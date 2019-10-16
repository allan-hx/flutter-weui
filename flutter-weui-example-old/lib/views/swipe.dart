import 'package:flutter/material.dart';
import '../layout/sample.dart';
import 'package:weui/weui.dart';
import '../components/title.dart';

class SwipePage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
}

class SwipePageState extends State {
  final GlobalKey swipeKey = GlobalKey();

  Widget itemBuilder (int index) {
    return Container(
      color: index % 2 == 0 ? Color(0xff39a9ed) : Color(0xff66c6f2),
      child: Align(
        alignment: Alignment.center,
        child: Text(index.toString(), style: TextStyle(
          color: Colors.white,
          fontSize: 18.0
        ))
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sample(
      'Swipe',
      describe: '轮播',
      child: Column(
        children: <Widget>[
          TextTitle('默认', noPadding: true),
          WeSwipe(
            autoPlay: false,
            height: 150.0,
            itemCount: 4,
            itemBuilder: itemBuilder
          ),
          // TextTitle('隐藏indicators', noPadding: true),
          // WeSwipe(
          //   height: 150.0,
          //   indicators: false,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // ),
          // TextTitle('禁止循环', noPadding: true),
          // WeSwipe(
          //   height: 150.0,
          //   cycle: false,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // ),
          // TextTitle('禁止自动播放', noPadding: true),
          // WeSwipe(
          //   height: 150.0,
          //   autoPlay: false,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // ),
          // TextTitle('默认展示第二页', noPadding: true),
          // WeSwipe(
          //   height: 150.0,
          //   defaultIndex: 1,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // ),
          // TextTitle('手动切换到指定页', noPadding: true),
          // WeSwipe(
          //   key: swipeKey,
          //   height: 150.0,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // ),
          // Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: WeButton(
          //     '外部控制',
          //     theme: WeButtonType.primary,
          //     onClick: () {
          //       (swipeKey.currentState as WeSwipeState).setIndex(2);
          //     }
          //   )
          // ),
          // TextTitle('自定义高度', noPadding: true),
          // WeSwipe(
          //   height: 250.0,
          //   itemCount: 4,
          //   itemBuilder: itemBuilder
          // )
        ]
      )
    );
  }
}
