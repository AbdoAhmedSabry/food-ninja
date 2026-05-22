import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_cubit.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_state.dart';

class ProductList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ProductList({super.key, this.shrinkWrap = false, this.physics});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final cubit = context.read<AdminCubit>();

        if (state is AdminLoading && cubit.productsList.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        }

        if (state is AdminError && cubit.productsList.isEmpty) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.font16BoldWhite.copyWith(color: Colors.red),
            ),
          );
        }

        if (cubit.productsList.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Text(
                'No products added yet.',
                style: AppTextStyles.font16BoldWhite,
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: cubit.productsList.length,
          padding: EdgeInsets.only(bottom: 20.h),
          itemBuilder: (context, index) {
            final product = cubit.productsList[index];

            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.transparent),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: product.imageurl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          color: Colors.white54,
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.font16BoldWhite,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$${product.price}',
                          style: AppTextStyles.font16BoldGreen.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          product.descreption,
                          style: AppTextStyles.font14NormalGrey.copyWith(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.deleteproduct(
                              imageUrl: product.imageurl,
                              productId: product.id,
                            );
                          },
                          child: Text(
                            "Delete",
                            style: AppTextStyles.font16BoldWhite.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
