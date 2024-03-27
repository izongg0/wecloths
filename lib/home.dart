import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wecloths/add_cloths.dart';
import 'package:wecloths/cloths_detail.dart';
import 'package:wecloths/controller/home_controller.dart';
import 'package:wecloths/model/ClothsModel.dart';

class ClothsList extends GetView<HomeController> {
  ClothsList({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AddCloths());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          "assets/appbarlogo.svg",
          width: 100,
        ),
        bottom: const TabBar(
          indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(
              child: Text(
                "아우터",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "상의",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "하의",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "신발",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "etc",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          ClothsListPage(
            clothsList: controller.outer,
          ),
          ClothsListPage(
            clothsList: controller.top,
          ),
          ClothsListPage(
            clothsList: controller.bottom,
          ),
          ClothsListPage(
            clothsList: controller.shoes,
          ),
          ClothsListPage(
            clothsList: controller.etc,
          ),
        ],
      ),
    );
  }
}

class ClothsListPage extends GetView<HomeController> {
  ClothsListPage({super.key, required this.clothsList});
  List<ClothsModel> clothsList;
  @override
  Widget build(BuildContext context) {
    if (clothsList.isEmpty) {
      return Center(
        child: Text(
          "No Cloths",
          style: TextStyle(color: Colors.grey[300], fontSize: 30),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 18.w, // 좌우 간격
                  runSpacing: 10, // 상하 간격
                  children: List.generate(clothsList.length, (index) {
                    return ClothItem(
                      clothsdata: clothsList[index],
                    );
                  }),
                )),
          ],
        ),
      );
    }
  }
}

class ClothItem extends GetView<HomeController> {
  ClothItem({super.key, required this.clothsdata});
  ClothsModel clothsdata;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ClothsDetail(clothsData: clothsdata));
      },
      child: Container(
        width: Get.width / 2.2,
        // height: 200.h,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 250.h,
              // color: Colors.blue,
              child: Image.memory(
                base64Decode(clothsdata.img!),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              clothsdata.title!,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text("${clothsdata.price!} 원")
          ],
        ),
      ),
    );
  }
}
