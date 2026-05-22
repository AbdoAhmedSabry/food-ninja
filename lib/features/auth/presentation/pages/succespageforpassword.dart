import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/features/auth/presentation/pages/login.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/widgets/authdesign_base.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:lottie/lottie.dart';

class SuccessPageforgot extends StatelessWidget {
  const SuccessPageforgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthdesignBase(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/success.json',
                height: 220.h,
                repeat: false,
              ),

              SizedBox(height: 10.h),

              Text("Check your email", style: AppTextStyles.font31BoldGreen),

              SizedBox(height: 12.h),

              Text(
                "We have sent a password recover instruction to your email",
                style: AppTextStyles.font20BoldWhite,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElevetedboutton(
                  title: "Ok",
                  width: double.infinity,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
