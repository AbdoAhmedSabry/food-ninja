import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryContainer({
    super.key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 44.h,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF23C87C)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.font14MediumWhite24.copyWith(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
