import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customText(
    {required String name,
      double? fontSize,
      Color? color,
      String? fontFamily,
      TextAlign? textAlign,
      Image? image,
    }) {
  return GestureDetector(
    child: Text(
      name,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize?? 28.sp,
        color: color?? primaryBlack,
      ),
    ),
  );
}