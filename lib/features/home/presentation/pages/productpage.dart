import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/home/presentation/widgets/custome_appbar.dart';
import 'package:foodninga/features/home/presentation/widgets/similarcard.dart';
import 'package:foodninga/features/home/presentation/widgets/slider.dart';

class Productpage extends StatelessWidget {
  const Productpage({super.key});

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
            colors: [
              Colors.black,
              // AppColors.secondary,
              const Color(0xFF23C87C).withOpacity(0.6),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCustomAppBar(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/pngwing12.png',
                      width: 200.w,
                      // height: 300.h,
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Burger Name",
                                style: AppTextStyles.font31BoldWhite.copyWith(
                                  fontSize: 28.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "200",
                                style: AppTextStyles.font31BoldGreen.copyWith(
                                  fontSize: 22.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),

                              Text(
                                "Product description goes here. This section will be updated automatically when real data is fetched from the API",
                                style: AppTextStyles.font14MediumWhite24
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                      height: 1,
                                    ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 5.h),
                          SliderAnimation(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text(
                        "Similar",
                        style: AppTextStyles.font20BoldWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),

                SizedBox(height: 0.25.sh, child: Similarcard()),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0.w,
                    vertical: 8.h,
                  ),
                  child: CustomElevetedboutton(
                    title: "Add to Cart",
                    width: double.infinity,
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
