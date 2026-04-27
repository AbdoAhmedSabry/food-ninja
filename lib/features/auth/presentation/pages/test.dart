import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              Lottie.asset('assets/lottie/success.json', height: 220.h),

              SizedBox(height: 10.h),

              Text("Congrats!", style: AppTextStyles.font31BoldGreen),

              SizedBox(height: 12.h),

              Text(
                "Your Profile Is Ready To Use",
                style: AppTextStyles.font20BoldWhite,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElevetedboutton(
                  title: "Try Order",
                  width: double.infinity,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
