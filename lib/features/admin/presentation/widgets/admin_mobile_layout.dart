import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/admin/presentation/widgets/add_product_form.dart';
import 'package:foodninga/features/admin/presentation/widgets/product_list.dart';

class AdminMobileLayout extends StatelessWidget {
  const AdminMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add New Product',
                style: AppTextStyles.font20BoldWhite.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Add product form section at the top
            const AddProductForm(),

            SizedBox(height: 25.h),

            // Section title for Product List
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product List',
                style: AppTextStyles.font20BoldWhite.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            // Scrollable Product list
            const ProductList(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
