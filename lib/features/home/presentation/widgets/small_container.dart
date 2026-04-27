import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';

class SmallContainer extends StatelessWidget {
  const SmallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: Text('Pizza', style: AppTextStyles.font14MediumWhite24),
      ),
    );
  }
}
