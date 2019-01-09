import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../views/index.dart';
import '../views/button.dart';
import '../views/call.dart';
import '../views/checklist.dart';
import '../views/radiolist.dart';
import '../views/icon.dart';
import '../views/slider.dart';
import '../views/input.dart';
import '../views/swipe.dart';
import '../views/badge.dart';
import '../views/grid.dart';
import '../views/loadmore.dart';
import '../views/progress.dart';
import '../views/toast.dart';
import '../views/actionsheet.dart';
import '../views/dialog.dart';
import '../views/drawer.dart';
import '../views/collapse.dart';
import '../views/imagePreview.dart';
import '../views/noticeBar.dart';
import '../views/switch.dart';

class Routes {
  static Router router;
  // 路由路径
  static Map<String, String> routerPath = {
    // 首页
    'index': '/',
    // 按钮
    'button': '/button',
    // cell
    'cell': '/cell',
    // checklist
    'checklist': '/checklist',
    // radio list
    'radio-list': '/radio-list',
    // icon
    'icon': '/icon',
    // slider
    'slider': '/slider',
    // input
    'input': '/input',
    // swipe
    'swipe': '/swipe',
    // badge
    'badge': '/badge',
    // grid
    'grid': '/grid',
    // loadmore
    'loadmore': '/loadmore',
    // progress
    'progress': '/progress',
    // toast
    'toast': '/toast',
    // actionsheet
    'actionsheet': '/actionsheet',
    // Dialog
    'dialog': '/dialog',
    // Drawer
    'drawer': '/drawer',
    // Collapse
    'collapse': '/collapse',
    // imagePreview
    'imagePreview': '/imagePreview',
    // noticeBar
    'noticeBar': '/noticeBar',
    // switch
    'switch': '/switch'
  };

  static init () {
    final paths = Routes.routerPath;
    Routes.router = new Router();
    // 路由
    final List<Map<String, Object>> routes = [
      {
        'path': paths['index'],
        // 'handler': (BuildContext context, Map params) => CallPage()
        'handler': (BuildContext context, Map params) => Index()
      },
      {
        'path': paths['button'],
        'handler': (BuildContext context, Map params) => ButtonPage()
      },
      {
        'path': paths['cell'],
        'handler': (BuildContext context, Map params) => CallPage()
      },
      {
        'path': paths['checklist'],
        'handler': (BuildContext context, Map params) => ChecklistPage()
      },
      {
        'path': paths['radio-list'],
        'handler': (BuildContext context, Map params) => RadioListPage()
      },
      {
        'path': paths['icon'],
        'handler': (BuildContext context, Map params) => WeIconsPage()
      },
      {
        'path': paths['slider'],
        'handler': (BuildContext context, Map params) => SliderPage()
      },
      {
        'path': paths['input'],
        'handler': (BuildContext context, Map params) => InputPage()
      },
      {
        'path': paths['swipe'],
        'handler': (BuildContext context, Map params) => SwipePage()
      },
      {
        'path': paths['badge'],
        'handler': (BuildContext context, Map params) => BadgePage()
      },
      {
        'path': paths['grid'],
        'handler': (BuildContext context, Map params) => GridPage()
      },
      {
        'path': paths['loadmore'],
        'handler': (BuildContext context, Map params) => Loadmore()
      },
      {
        'path': paths['progress'],
        'handler': (BuildContext context, Map params) => ProgressPage()
      },
      {
        'path': paths['toast'],
        'handler': (BuildContext context, Map params) => ToastPage()
      },
      {
        'path': paths['actionsheet'],
        'handler': (BuildContext context, Map params) => ActionsheetPage()
      },
      {
        'path': paths['dialog'],
        'handler': (BuildContext context, Map params) => DialogPage()
      },
      {
        'path': paths['drawer'],
        'handler': (BuildContext context, Map params) => DrawerPage()
      },
      {
        'path': paths['collapse'],
        'handler': (BuildContext context, Map params) => CollapsePage()
      },
      {
        'path': paths['imagePreview'],
        'handler': (BuildContext context, Map params) => ImagePreviewPage()
      },
      {
        'path': paths['noticeBar'],
        'handler': (BuildContext context, Map params) => NoticeBarPage()
      },
      {
        'path': paths['switch'],
        'handler': (BuildContext context, Map params) => SwitchPage()
      }
    ];

    // 遍历
    routes.forEach((route) {
      Routes.router.define(
        route['path'],
        handler: Handler(
          handlerFunc: route['handler']
        )
      );
    });
  }
}
