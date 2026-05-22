import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/home/presentation/pages/productpage.dart';

class CardInfo extends StatelessWidget {
  final ProductEntite product;
  const CardInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productpage(product: product),
          ),
        );
      },
      child: Container(
        width: 145.w,
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageurl,
                height: 110.h,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font16BoldWhite,
            ),

            SizedBox(height: 4.h),

            Text(
              product.descreption,
              maxLines: 2,

              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font14NormalGrey.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),

            SizedBox(height: 6.h),

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
