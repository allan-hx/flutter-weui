import 'package:flutter/material.dart';
import '../router/index.dart';
import '../components/list-item.dart';
import '../weui/index.dart';

final Map<String, String> routerPath = Routes.routerPath;

class Index extends StatelessWidget {
  // 标题padding
  final double titlePadding = 36.0;
  // 列表
  final list = [
    {
      'title': '表单',
      'icon': 'assets/images/index-icon/icon_nav_form.png',
      'childer': [
        {
          'title': 'Button',
          'url': routerPath['button']
        },
        {
          'title': 'Checklist',
          'url': routerPath['checklist']
        },
        {
          'title': 'Radiolist',
          'url': routerPath['radio-list']
        },
        {
          'title': 'Input',
          'url': routerPath['input']
        },
        {
          'title': 'Cell',
          'url': routerPath['cell']
        },
        {
          'title': 'Slider',
          'url': routerPath['slider']
        },
        {
          'title': 'Uploader',
          'url': null
        },
        {
          'title': 'Switch',
          'url': routerPath['switch']
        }
      ]
    },
    {
      'title': '基础组建',
      'icon': 'assets/images/index-icon/icon_nav_layout.png',
      'childer': [
        {
          'title': 'Badge',
          'url': routerPath['badge']
        },
        {
          'title': 'Gallery',
          'url': null
        },
        {
          'title': 'Grid',
          'url': routerPath['grid']
        },
        {
          'title': 'Icons',
          'url': routerPath['icon']
        },
        {
          'title': 'Loadmore',
          'url': routerPath['loadmore']
        }
      ]
    },
    {
      'title': '展示组件',
      'icon': 'assets/images/index-icon/icon_nav_layout.png',
      'childer': [
        {
          'title': 'Swipe',
          'url': routerPath['swipe']
        },
        {
          'title': 'Progress',
          'url': routerPath['progress']
        },
        {
          'title': 'Collapse',
          'url': routerPath['collapse']
        },
        {
          'title': 'imagePreview',
          'url': routerPath['imagePreview']
        },
        {
          'title': 'noticeBar',
          'url': routerPath['noticeBar']
        }
      ]
    },
    {
      'title': '操作反馈',
      'icon': 'assets/images/index-icon/icon_nav_feedback.png',
      'childer': [
        {
          'title': 'Drawer',
          'url': routerPath['drawer']
        },
        {
          'title': 'Actionsheet',
          'url': routerPath['actionsheet']
        },
        {
          'title': 'Dialog',
          'url': routerPath['dialog']
        },
        {
          'title': 'Picker',
          'url': null
        },
        {
          'title': 'Toast',
          'url': routerPath['toast']
        }
      ]
    }
  ];

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
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
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: ListItem(list, click: (item) {
              if (item['url'] == null) {
                WeToast.info(context)('正在努力开发中...', duration: 1500);
                return;
              }
              Routes.router.navigateTo(context, item['url']);
            })
          )
        ]
      )
    );
  }
}