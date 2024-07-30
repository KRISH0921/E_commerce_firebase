import 'package:e_commerce_firebase/app/them/color_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFromField extends StatefulWidget {
   CustomTextFromField({
    super.key,
    required this.labelText,
    this.validator,
    this.height,
    this.textColor,
    this.fontFamily,
    this.fontSize,
    this.line,
    this.controller,
    this.obscureText = false,
    this.textInputType,
     this.suffixIcon,
   });

   String labelText;
   bool obscureText;
   String? Function(String?)? validator;
   IconButton? suffixIcon;
   Color? textColor;
   String? fontFamily;
   double? fontSize;
   double? height;
   int? line;
   TextEditingController? controller;
   TextInputType? textInputType;

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryPlatinum,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h), // Adjust padding as needed
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: widget.textColor ?? primaryAshGrey,
              fontFamily: widget.fontFamily ?? "PoppinsRegular",
              fontSize: widget.fontSize ?? 19.sp,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.h), // Adjust content padding for better alignment
          ),
        ),
      ),
    );
  }
}
