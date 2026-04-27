import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:pinput/pinput.dart';

class Otpwidget extends StatelessWidget {
  const Otpwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70.w,
      height: 70.h,
      textStyle: AppTextStyles.font31BoldWhite,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5.r),
      ),
    );

    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          "Enter 4-digit\nVerification code",
          style: AppTextStyles.font20BoldWhite,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Text(
          "Code send to +6282045**** . This code will\n expire in 01:30",
          style: AppTextStyles.font14MediumWhite24,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 38.h),

        Pinput(
          length: 4,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: const Color(0xFF53E88B), width: 2.r),
            ),
          ),
          onCompleted: (pin) => print(pin),
        ),
      ],
    );
  }
}
