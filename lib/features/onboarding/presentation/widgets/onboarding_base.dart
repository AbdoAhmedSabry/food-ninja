import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardingWidget extends StatelessWidget {
  final String lottieImage;
  final String description;

  const OnboardingWidget({
    super.key,
    required this.lottieImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(
              lottieImage,
              height: 300.h,
              fit: BoxFit.contain,
              frameRate: FrameRate.max,
            ),
          ),
          SizedBox(height: 40.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ), // تأكدت من إضافة لون النص لأن الخلفية سوداء
          ),
        ],
      ),
    );
  }
}
