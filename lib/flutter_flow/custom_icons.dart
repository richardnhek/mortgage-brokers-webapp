import 'package:flutter/widgets.dart';

class FFIcons {
  FFIcons._();

  static const String _mainWebNavFamily = 'MainWebNav';
  static const String _othersFamily = 'Others';
  static const String _notificationFamily = 'Notification';

  // main-web-nav
  static const IconData kchats =
      IconData(0xe900, fontFamily: _mainWebNavFamily);
  static const IconData kworkspace =
      IconData(0xe901, fontFamily: _mainWebNavFamily);

  // others
  static const IconData kmute = IconData(0xe900, fontFamily: _othersFamily);
  static const IconData kpin = IconData(0xe901, fontFamily: _othersFamily);
  static const IconData klogout = IconData(0xe902, fontFamily: _othersFamily);

  // notification
  static const IconData knotification =
      IconData(0xe900, fontFamily: _notificationFamily);
}
