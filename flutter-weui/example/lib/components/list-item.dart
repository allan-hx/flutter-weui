import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  List<Map<String, Object>> list = [];
  dynamic click;

  ListItem(list, { click }) {
    this.list = list;
    this.click = click;
  }

  @override
  ListItemState createState() {
    return ListItemState(list, click: click);
  }
}

class ListItemState extends State {
  List<Map<String, Object>> list = [];
  var click;
  // 当前展示的列表
  int index;
  // 列表左右padding
  final double listPadding = 18.0;

  ListItemState(list, { click }) {
    this.list = list;
    this.click = click;
  }

  // 渲染二级列表
  List<Widget> renderSubItem(subList) {
    List<Widget> widgetList = [];
    // 循环数组
    subList.forEach((dynamic item) {
      widgetList.add(
        InkWell(
          onTap: () {
            if (click is Function) {
              click(item);
            }
          },
          child: Column(
            children: <Widget>[
              Divider(height: 1.0),
              Container(
                padding: EdgeInsets.only(
                  top: 16.0,
                  right: listPadding,
                  bottom: 16.0,
                  left: listPadding
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(item['title'], style: TextStyle(
                        fontSize: 16.0
                      ))
                    ),
                    Container(
                      child: Image.asset('assets/images/right-icon.png', height: 16.0)
                    )
                  ]
                )
              )
            ]
          )
        )
      );
    });

    return widgetList;
  }

  // 渲染一级列表
  Widget renderItem(data, eq, isOne) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      child: Container(
        margin: EdgeInsets.only(top: isOne ? 0 : 10.0),
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (index == eq) {
                      index = null;
                    } else {
                      index = eq;
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 25.0,
                    right: listPadding,
                    bottom: 25.0,
                    left: listPadding
                  ),
                  child: Row(
                    children: <Widget>[
                      // 名称
                      Expanded(
                        flex: 1,
                        child: Text(data['title'], style: TextStyle(
                          fontSize: 16.0
                        ))
                      ),
                      Image.asset(data['icon'], height: 22.0)
                    ]
                  )
                )
              )
            ),
            Container(
              child: Material(
                color: Colors.white,
                child: eq == index ? Column(
                  children: renderSubItem(data['childer'])
                ) : null
              )
            )
          ]
        )
      )
    );
  }

  Widget build(BuildContext context) {
    List<Widget> itemList = [];
    // 遍历列表
    list.forEach((item) {
      itemList.add(
        renderItem(item, list.indexOf(item), item == list[0])
      );
    });

    return Container(
      child: Column(
        children: itemList
      )
    );
  }
}
