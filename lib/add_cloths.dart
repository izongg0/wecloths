import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecloths/controller/add_cloths_controller.dart';

class AddCloths extends StatefulWidget {
  AddCloths({super.key});

  @override
  State<AddCloths> createState() => _AddClothsState();
}

class _AddClothsState extends State<AddCloths> {
  // File? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  final controller = Get.put(AddClothController());
  // String? selectedItem;
void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      controller.image.value = File(pickedFile.path); //가져온 이미지를 _image에 저장
    }
  }

  Widget buildListItem(String item) {
    return GestureDetector(
      onTap: () {
        controller.selectedItem.value = item;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: controller.selectedItem.value == item
              ? Colors.grey[300]
              : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          item,
          style: TextStyle(
            color: controller.selectedItem.value == item
                ? Colors.black
                : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: SvgPicture.asset(
              "assets/appbarlogo.svg",
              width: 100,
            ),
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                Obx(() => SizedBox(
                      height: 200.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "* 상품이미지",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  OutlinedButton(
                                      onPressed: () async {
                                        await getImage(ImageSource.gallery);
                                      },
                                      child: const Text(
                                        "첨부",
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                            if (controller.image.value != null)
                              Container(
                                width: 120.w,
                                height: 200.h,
                                color: Colors.black,
                                child: Image.file(controller.image.value!,fit: BoxFit.cover,),
                              )
                            else
                              Container(
                                width: 120.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                          ]),
                    )),
                SizedBox(
                  height: 20,
                ),
                Obx(() => SizedBox(
                    height: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildListItem('아우터'),
                        buildListItem('상의'),
                        buildListItem('하의'),
                        buildListItem('신발'),
                        buildListItem('기타'),
                      ],
                    ))),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                    height: 50.h,
                    child: TextField(
                      
                      controller: controller.inputTitleController,
                      decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 11),
      
                          hintText: "제품명",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    height: 50.h,
                    child: TextField(
                      
                      controller: controller.inputPriceController,
                      decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 11),
      
                          hintText: "가격",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    height: 50.h,
                    child: TextField(
                      controller: controller.inputLinkController,
                      decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 11),
      
                          hintText: "사이트 주소",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    height: 150.h,
                    child: TextField(
                      controller: controller.inputDesController,
                      maxLines: 7,
                      decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 11,vertical: 10),
      
                          hintText: "설명",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 50.h,
                      child: OutlinedButton(
                          onPressed: () async {
                            await controller.addCloth(context);
                          },
                          child: const Text(
                            "저장",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 50.h,
                      child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("취소",
                              style: TextStyle(color: Colors.black))),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
