import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hinttext,
    required this.prefix,
    this.height = 70,
    this.width = 327,
    this.validator,
    this.controller,
    this.obscureText,
    this.inputType,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hinttext;
  final Widget? prefix;
  final double height;
  final double width;
  final bool? obscureText;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: TextFormField(
        keyboardType: inputType,
        obscureText: obscureText ?? false,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          prefixIcon: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.07),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.5.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}
