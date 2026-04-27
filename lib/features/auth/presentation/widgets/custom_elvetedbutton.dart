import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';

class CustomElevetedboutton extends StatelessWidget {
  const CustomElevetedboutton({
    super.key,
    required this.title,
    this.width = 157,
    this.heigth = 57,
    this.onPressed,
  });

  final String title;
  final double? width;
  final double? heigth;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(
        15.r,
      ),
      child: Container(
        width: width!.w,
        height: heigth!.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.primary,
         
        ),
        child: Center(
          child: Text(title, style: AppTextStyles.font16BoldWhiteButton),
        ),
      ),
    );
  }
}
