import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/home/presentation/pages/productpage.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Productpage()),
        );
      },
      child: Container(
        width: 145.w,
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1.5.w,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/image5.png",
                height: 110.h,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 14.h),

            Text("Hamburger", style: AppTextStyles.font16BoldWhite),

            SizedBox(height: 4.h),

            Text(
              "Veggie Burger",
              style: AppTextStyles.font14MediumWhite24.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 22),
                SizedBox(width: 4.w),
                Text("4.8", style: AppTextStyles.font14MediumWhite24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
