import 'package:flutter/material.dart';
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
import '../views/tip.dart';
import '../views/notify.dart';
import '../views/picker_view.dart';
import '../views/checkbox.dart';
import '../views/radio.dart';
import '../views/spin.dart';

final routes = <String, WidgetBuilder>{
  // 按钮
  '/button': (_) => ButtonPage(),
  // cell
  '/cell': (_) => CallPage(),
  // checklist
  '/checklist': (_) => ChecklistPage(),
  // radio list
  '/radiolist': (_) => RadioListPage(),
  // icon
  '/icon': (_) => WeIconsPage(),
  // slider
  '/slider': (_) => SliderPage(),
  // input
  '/input': (_) => InputPage(),
  // swipe
  '/swipe': (_) => SwipePage(),
  // badge
  '/badge': (_) => BadgePage(),
  // grid
  '/grid': (_) => GridPage(),
  // loadmore
  '/loadmore': (_) => Loadmore(),
  // progress
  '/progress': (_) => ProgressPage(),
  // toast
  '/toast': (_) => ToastPage(),
  // actionsheet
  '/actionsheet': (_) => ActionsheetPage(),
  // Dialog
  '/dialog': (_) => DialogPage(),
  // Drawer
  '/drawer': (_) => DrawerPage(),
  // Collapse
  '/collapse': (_) => CollapsePage(),
  // imagePreview
  '/imagePreview': (_) => ImagePreviewPage(),
  // noticeBar
  '/noticeBar': (_) => NoticeBarPage(),
  // switch
  '/switch': (_) => SwitchPage(),
  // tip
  '/tip': (_) => TipPage(),
  // notify
  '/notify': (_) => NotifyPage(),
  // pickView
  '/picker_view': (_) => PickerViewPage(),
  // checkbox
  '/checkbox': (_) => CheckboxPage(),
  // radio
  '/radio': (_) => RadioPage(),
  // spin
  '/spin': (_) => SpinPage(),
};
