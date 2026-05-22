import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/admin/presentation/widgets/add_product_form.dart';
import 'package:foodninga/features/admin/presentation/widgets/product_list.dart';

class AdminWebLayout extends StatelessWidget {
  const AdminWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Fixed width for Web to prevent excessive stretching)
          SizedBox(
            width: 400, // Fixed physical pixels
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Product',
                    style: AppTextStyles.font20BoldWhite.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const AddProductForm(),
                ],
              ),
            ),
          ),
          SizedBox(width: 40.w), // Space between sidebar and list
          
          // Main content (Product List takes remaining space)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product List',
                  style: AppTextStyles.font20BoldWhite.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 15.h),
                const Expanded(
                  child: ProductList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
