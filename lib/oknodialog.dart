import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupWidget extends StatelessWidget {
  String content;
  final Function()? okfunc;
  final Function()? nofunc;

  PopupWidget({
    super.key,
    required this.content,
    required this.okfunc,
    required this.nofunc
  
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            // 창 둥글게
            borderRadius: BorderRadius.circular(20),
            child: Container(
              
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 30.h,
                          child: OutlinedButton(
                            onPressed: okfunc, child: Text("네")),
                        ),
                         SizedBox(
                          width: 100.w,
                          height: 30.h,
                          child: OutlinedButton(
                            onPressed: nofunc, child: Text("아니오")),
                        )
                       
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
