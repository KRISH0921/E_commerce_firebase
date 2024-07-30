import 'package:e_commerce_firebase/app/components/custom_text.dart';
import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.name,
    required this.onTap,
    this.buttonColor,
    this.fontFamily,
    this.fontColor,
    this.height,
    this.fontSize,
    this.process,
    this.borderRadius,
  });

  String name;
  Function onTap;
  Color? buttonColor;
  String? fontFamily;
  Color? fontColor;
  double? height;
  double? fontSize;
  bool? process;
  BorderRadius? borderRadius;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap.call();
      },
      child: Container(
        height: widget.height ?? 66.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? primaryMitBlue,
          borderRadius: widget.borderRadius ?? BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        alignment: Alignment.center,
        child: widget.process == true ? CircularProgressIndicator(color: primaryWight,) : customText(
          name: widget.name,
          fontSize: widget.fontSize ?? 16.sp,
          color: widget.fontColor ?? primaryWight,
          fontFamily: widget.fontFamily ?? "",
        ),
      ),
    );
  }
}
