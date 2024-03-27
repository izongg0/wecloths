import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecloths/controller/home_controller.dart';
import 'package:wecloths/main.dart';
import 'package:wecloths/oknodialog.dart';
import 'package:wecloths/repo/post_helper.dart';

class ClothsController extends GetxController {
  final _postHelper = DBHelper();

  Future<void> deleteCloths(BuildContext context, int clothId) async {
    await showDialog(
        context: context,
        builder: (context) => PopupWidget(
              content: '삭제 하시겠습니까?',
              okfunc: () async {
                await _postHelper.deleteItem(clothId);
                // onInit();

                Get.find<HomeController>().onInit();
                Get.back();
                Get.back();
                // Get.snackbar('삭제되었습니다!', '',
                //     snackPosition: SnackPosition.BOTTOM);
              },
              nofunc: () async {
                Get.back();
              },
            ));
  }
}
