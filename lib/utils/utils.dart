

import 'package:permission_handler/permission_handler.dart';

class Utils{

  static Future<bool> get  requestPermissionNotification async =>   await Permission.notification.isDenied.then((value) async {
    if (value) {
      Permission.notification.request();
    }
    return await Permission.notification.isDenied;
  });



}