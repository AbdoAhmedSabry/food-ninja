import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/home/presentation/widgets/cardlist.dart';
import 'package:foodninga/features/home/presentation/widgets/home_title.dart';
import 'package:foodninga/features/home/presentation/widgets/navigation.dart';
import 'package:foodninga/features/home/presentation/widgets/small_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: AppColors.secondary,
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
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 8.h),
              CustomTextfield(
                height: 77.h,
                width: 360.w,
                hinttext: "What do you want to order?",
                prefix: Icon(Icons.search, color: AppColors.primary),
              ),

              SizedBox(
                height: 48.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
                      child: SmallContainer(),
                    );
                  },
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      child: Text(
                        "Popular Menu",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Cardlist(),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
