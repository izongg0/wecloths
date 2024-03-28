import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecloths/controller/home_controller.dart';
import 'package:wecloths/model/ClothsModel.dart';
import 'package:wecloths/repo/post_helper.dart';

class AddClothController extends GetxController {
  Rx<File?> image = Rx<File?>(null); // Rx 변수를 사용하여 상태 관리

  var selectedItem = "".obs;

  TextEditingController inputTitleController = TextEditingController();
  TextEditingController inputPriceController = TextEditingController();
  TextEditingController inputLinkController = TextEditingController();
  TextEditingController inputDesController = TextEditingController();

  final _postHelper = DBHelper();

  Future<void> addCloth(BuildContext context) async {
    if (image.value == null) {
      Get.snackbar('이미지를 선택해주세요.', '',
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    } else if (selectedItem.value == "") {
      Get.snackbar('카테고리를 선택해주세요.', '',
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    } else {
      List<int> imageBytes = image.value!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      var addClothData = ClothsModel(
          img: base64Image,
          category: selectedItem.value,
          link: inputLinkController.text,
          title: inputTitleController.text,
          content: inputDesController.text,
          price: inputPriceController.text);
      // print(addClothData.toMap());
      try {
        var insertid = await _postHelper.insertItem(addClothData);
        print(insertid);
        print("성공");
        HomeController.to.onInit();
        Get.back();
        Get.snackbar('생성되었습니다!', '',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 1));

        // Navigator.pop(context);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
