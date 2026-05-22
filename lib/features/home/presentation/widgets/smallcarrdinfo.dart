import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:shimmer/shimmer.dart';

class SmallFoodCard extends StatelessWidget {
  const SmallFoodCard({super.key, required this.product});
  final ProductEntite product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5.w),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.imageurl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Padding(
                padding: EdgeInsets.all(20.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.05),
                  highlightColor: Colors.white.withOpacity(0.15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.image_not_supported,
                color: Colors.white54,
                size: 30.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            product.name,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          Text(
            product.price.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
