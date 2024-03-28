import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wecloths/model/ClothsModel.dart';
import 'package:wecloths/repo/post_helper.dart';

class HomeController extends GetxController {

    static HomeController get to => Get.find();

  RxList<ClothsModel> total = RxList<ClothsModel>();

  RxList<ClothsModel> outer = RxList<ClothsModel>();
  RxList<ClothsModel> top = RxList<ClothsModel>();
  RxList<ClothsModel> bottom = RxList<ClothsModel>();
  RxList<ClothsModel> shoes = RxList<ClothsModel>();
  RxList<ClothsModel> etc = RxList<ClothsModel>();
  final _postHelper = DBHelper();

  void onInit() async {
    await divideCloths();

    super.onInit();
  }

  Future<void> listClear() async {
    outer.clear();
    bottom.clear();
    shoes.clear();
    top.clear();
    etc.clear();
  }

  Future<void> divideCloths() async {
    await listClear();
    total.value = await _postHelper.getItems();
    // print("시작${total.value}");
    for (var item in total) {
      if (item.category == '아우터') {
        outer.add(item);
      } else if (item.category == '상의') {
        top.add(item);
      } else if (item.category == '하의') {
        bottom.add(item);
      } else if (item.category == '신발') {
        shoes.add(item);
      } else if (item.category == '기타') {
        etc.add(item);
      }
    }
    print("끝${total.value}");
    // print(top);
  }
}
