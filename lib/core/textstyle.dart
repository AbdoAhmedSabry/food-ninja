import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart'; // تأكد إن مسار الملف ده صح عندك

class AppTextStyles {
  // 1. العناوين الكبيرة الرئيسية
  static TextStyle get font31BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 31.sp, // إضافة .sp
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  // 2. عناوين الأقسام والأسماء البارزة
  static TextStyle get font20BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 3. أسماء الوجبات في الكروت أو العناوين الفرعية
  static TextStyle get font16BoldWhite => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 4. السعر المميز باللون الأخضر
  static TextStyle get font16BoldGreen => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary, // استدعاء اللون من ملف الكور
  );

  // 5. النصوص العادية والوصف (Description)
  static TextStyle get font14NormalGrey => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    height: 1.5,
  );

  // 6. نصوص الـ Hint داخل الـ TextFields
  static TextStyle get font14MediumWhite24 => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white24,
  );

  // 7. نصوص الأزرار
  static TextStyle get font16BoldWhiteButton => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 8. العنوان الأخضر الكبير
  static TextStyle get font31BoldGreen => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 31.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary, // استدعاء اللون من ملف الكور
  );
}
