import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weui/weui.dart';
import 'package:weui/theme.dart';
import 'package:barcode_scan/barcode_scan.dart';
import '../router/index.dart';

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State {
  // 标题padding
  final double titlePadding = 36.0;
  // 列表左右padding
  final double listPadding = 18.0;
  // 列表
  final list = [
    {
      'title': '表单',
      'icon': 'assets/images/index-icon/icon_nav_form.png',
      'childer': [
        {
          'title': 'Button',
          'url': '/button'
        },
        {
          'title': 'Checklist',
          'url': '/checklist'
        },
        {
          'title': 'Radiolist',
          'url': '/radiolist'
        },
        {
          'title': 'Input',
          'url': '/input'
        },
        {
          'title': 'Slider',
          'url': '/slider'
        },
        {
          'title': 'Uploader',
          'url': null
        },
        {
          'title': 'Switch',
          'url': '/switch'
        },
        {
          'title': 'PickerView',
          'url': '/picker_view'
        }
      ]
    },
    {
      'title': '基础组建',
      'icon': 'assets/images/index-icon/icon_nav_layout.png',
      'childer': [
        {
          'title': 'Badge',
          'url': '/badge'
        },
        {
          'title': 'Cell',
          'url': '/cell'
        },
        {
          'title': 'Grid',
          'url': '/grid'
        },
        {
          'title': 'Icons',
          'url': '/icon'
        },
        {
          'title': 'Loadmore',
          'url': '/loadmore'
        }
      ]
    },
    {
      'title': '展示组件',
      'icon': 'assets/images/index-icon/icon_nav_layout.png',
      'childer': [
        {
          'title': 'Swipe',
          'url': '/swipe'
        },
        {
          'title': 'Progress',
          'url': '/progress'
        },
        {
          'title': 'Collapse',
          'url': '/collapse'
        },
        {
          'title': 'imagePreview',
          'url': '/imagePreview'
        },
        {
          'title': 'noticeBar',
          'url': '/noticeBar'
        }
      ]
    },
    {
      'title': '操作反馈',
      'icon': 'assets/images/index-icon/icon_nav_feedback.png',
      'childer': [
        {
          'title': 'Drawer',
          'url': '/drawer'
        },
        {
          'title': 'Actionsheet',
          'url': '/actionsheet'
        },
        {
          'title': 'Dialog',
          'url': '/dialog'
        },
        {
          'title': 'Toast',
          'url': '/toast'
        },{
          'title': 'notify',
          'url': '/notify'
        },
        {
          'title': 'tip',
          'url': '/tip'
        }
      ]
    }
  ];

  // 二维码
  void scan() async {
    final toast = WeToast.info(context);
    try {
      final String url = await BarcodeScanner.scan();
      if (routes[url] == null) {
        toast('二维码错误, 请扫描文档上的二维码');
      } else {
        Navigator.of(context).pushNamed(url);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        toast('请授权相机权限');
      } else {
        toast('Unknown error: $e');
      }
    }
  }

  // 渲染二级列表
  List<Widget> renderSubItem(subList) {
    final List<Widget> widgetList = [];

    // 循环数组
    subList.forEach((dynamic item) {
      final List<Widget> content = [
        Container(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0
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
      ];

      // 第一个不添加边框
      if (subList.indexOf(item) > 0) {
        content.insert(0, Divider(height: 1, color: defaultBorderColor));
      }

      widgetList.add(
        InkWell(
          onTap: () {
            if (item['url'] == null) {
              WeToast.info(context)('正在努力开发中...', duration: 1500);
              return;
            }
            Navigator.of(context).pushNamed(item['url']);
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: listPadding,
              right: listPadding
            ),
            child: Column(
              children: content
            )
          )
        )
      );
    });

    return widgetList;
  }

  // 渲染标题
  Widget buildTitle(bool checked, int index, Widget child) {
    return Opacity(
      opacity: checked ? 0.5 : 1.0,
      child: Padding(
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
              child: child
            ),
            Image.asset(list[index]['icon'], height: 22.0)
          ]
        )
      )
    );
  }

  // 渲染内容
  Widget buildContent(bool checked, int index, Widget child) {
    return child;
  }

  @override
  Widget build (BuildContext context) {
    final List<WeCollapseItem> children = [];

    list.forEach((item) {
      children.add(
        WeCollapseItem(
          title: Text(item['title'], style: TextStyle(
            fontSize: 16.0
          )),
          child: Column(
            children: renderSubItem(item['childer'])
          )
        )
      );
    });

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        backgroundColor: primary,
        child: Icon(IconData(0xe618, fontFamily: 'iconfont'))
      ),
      body: ListView(
        children: <Widget>[
          // head
          Container(
            padding: EdgeInsets.all(36.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Flutter WeUi', style: TextStyle(
                      fontSize: 25.0
                    ))
                  ]
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('WeUI 是一套同微信原生视觉体验一致的基础样式库，由微信官方设计团队为微信内网页和微信小程序量身设计，令用户的使用感知更加统一。', style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xff888888)
                  ))
                )
              ]
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0),
            child: WeCollapse(
              card: true,
              accordion: true,
              buildTitle: buildTitle,
              buildContent: buildContent,
              children: children
            )
          )
        ]
      )
    );
  }
}
