import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart'; // Ensure this path is correct

class AppTextStyles {
  // 1. Main Large Headings
  static TextStyle get font31BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 31.sp, // add .sp
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  // 2. Section Headings and Prominent Names
  static TextStyle get font20BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 3. Meal Names in Cards or Subheadings
  static TextStyle get font16BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 4. Featured Price in Green
  static TextStyle get font16BoldGreen => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary, // Import color from core file
  );

  // 5. Normal Texts and Description
  static TextStyle get font14NormalGrey => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    height: 1.5,
  );

  // 6. Hint Texts inside TextFields
  static TextStyle get font14MediumWhite24 => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white24,
  );

  // 7. Button Texts
  static TextStyle get font16BoldWhiteButton => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 8. Large Green Heading
  static TextStyle get font31BoldGreen => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 31.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary, // Import color from core file
  );
}
