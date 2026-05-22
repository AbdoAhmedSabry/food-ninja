import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';

class Cartbottembar extends StatelessWidget {
  const Cartbottembar({
    super.key,
    required this.totalPrice,
    required this.onCheckOutPressed,
  });
  final double totalPrice;
  final VoidCallback onCheckOutPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "\$${totalPrice}",
                  style: AppTextStyles.font20BoldWhite.copyWith(
                    color: const Color(0xFF23C87C),
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ),

            CustomElevetedboutton(
              title: "Check out",
              width: 160.w,
              onPressed: onCheckOutPressed,
            ),
          ],
        ),
      ),
    );
  }
}
