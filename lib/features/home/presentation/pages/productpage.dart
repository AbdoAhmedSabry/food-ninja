import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/di/service_locator.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:foodninga/features/home/presentation/pages/cartpage.dart';
import 'package:foodninga/features/home/presentation/widgets/custome_appbar.dart';
import 'package:foodninga/features/home/presentation/widgets/similarcard.dart';
import 'package:foodninga/features/home/presentation/widgets/slider.dart';

class Productpage extends StatelessWidget {
  const Productpage({super.key, required this.product});
  final ProductEntite product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, const Color(0xFF23C87C).withOpacity(0.6)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCustomAppBar(),

                // SizedBox(height: 10.h),
                Center(
                  child: Image.network(
                    product.imageurl,
                    width: 250.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.font31BoldWhite.copyWith(
                          fontSize: 28.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Text(
                        product.descreption,
                        style: AppTextStyles.font14MediumWhite24.copyWith(
                          color: Colors.white.withOpacity(0.6),
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SliderAnimation()),
                          SizedBox(width: 20.w),
                          Text(
                            product.price.toString(),
                            style: AppTextStyles.font31BoldGreen.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text("Similar", style: AppTextStyles.font20BoldWhite),
                ),
                SizedBox(height: 15.h),

                SizedBox(
                  height: 0.25.sh,
                  child: BlocProvider(
                    create: (context) =>
                        getIt<HomeCubit>()
                          ..getproductsbycategory(product.category),
                    child: Similarcard(product: product),
                  ),
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  child: CustomElevetedboutton(
                    title: "Add to Cart",
                    width: double.infinity,
                    onPressed: () {
                      context.read<CartCubit>().addToCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Added to Cart Successfully! 🛒",
                                style: AppTextStyles.font16BoldWhite,
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF23C87C),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
