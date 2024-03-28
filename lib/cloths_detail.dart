import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wecloths/controller/cloth_controller.dart';
import 'package:wecloths/model/ClothsModel.dart';

class ClothsDetail extends StatelessWidget {
  ClothsDetail({super.key, required this.clothsData});
  ClothsModel clothsData;

  final controller = Get.put(ClothsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: SvgPicture.asset(
            "assets/appbarlogo.svg",
            width: 100,
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () async {
                  await controller.deleteCloths(context, clothsData.id!);
                },
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.black,
                ),
              ),
            )
          ],
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ClothsView(
                      image: clothsData.img!,
                    ));
                  },
                  child: Container(
                    width: 330.w,
                    height: 500.h,
                    color: Colors.white,
                    child: Image.memory(
                      base64Decode(clothsData.img!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.9,
                  child: Text(
                    clothsData.title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "${clothsData.price!} 원",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 8.h,
                ),
                if (clothsData.link != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // try {
                          //   launchUrl(
                          //       Uri.parse('https://pub.dev/packages/url_launcher'));
                          // } catch (e) {
                          //   Get.snackbar('링크가 잘못되었습니다.', '',
                          //       snackPosition: SnackPosition.BOTTOM);
                          // }
                        },
                        child: SizedBox(
                          width: Get.width * 0.6,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            clothsData.link!,
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Container(
                        height: 30.h,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.grey),
                                )),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: clothsData.link!));
                              Get.snackbar('복사되었습니다!', '',
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 1));
                            },
                            child: Text("copy")),
                      )
                    ],
                  ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.9,
                    child: Text(clothsData.content!))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClothsView extends StatelessWidget {
  ClothsView({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        child: PhotoView(
          imageProvider: MemoryImage(
            base64Decode(image),
          ),
          minScale: PhotoViewComputedScale.contained,
          initialScale: PhotoViewComputedScale.contained,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
      Positioned(
        top: 50,
        right: 15,
        child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Colors.grey,
              size: 35.w,
            )),
      ),
    ]);
  }
}
