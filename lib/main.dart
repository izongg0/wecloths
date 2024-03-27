import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:wecloths/add_cloths.dart';
import 'package:wecloths/cloths_detail.dart';

import 'package:wecloths/controller/home_controller.dart';
import 'package:wecloths/home.dart';
import 'package:wecloths/model/ClothsModel.dart';
import 'package:wecloths/splash.dart';

void main() {
  runApp(MainApp());

//  runApp(
//     DevicePreview(
//       enabled: true,
//       tools: [
//         ...DevicePreview.defaultTools,
//       ],
//       builder: (context) => const MainApp(),//     ),
//   );
}

class MainApp extends GetView<HomeController> {
  MainApp({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: const GetMaterialApp(
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: Splash()),
    );
  }
}

