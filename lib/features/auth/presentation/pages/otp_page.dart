import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/otpwidget.dart';
import 'package:foodninga/features/auth/presentation/widgets/authdesign_base.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthdesignBase(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              Otpwidget(),

              const Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElevetedboutton(
                  title: "Next",
                  width: double.infinity,
                  onPressed: () {
                    // Navigate to Success View
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
