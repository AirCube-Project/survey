import 'package:flutter_driver/driver_extension.dart';
import 'package:sampleapp/main.dart' as app;

import 'app_test.dart';

void main() {
  // Future<String> dataHandler(String msg) async {
  //   switch (msg) {
  //     case "change_gender":
  //       {
  //         MockHelper.ChangeGenderMock();
  //       }
  //       break;
  //     default:
  //       break;
  //   }
  // }
  enableFlutterDriverExtension();
  app.main();
}