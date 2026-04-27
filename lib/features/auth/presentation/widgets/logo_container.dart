import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodninga/core/app_images.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(AppImages.pattern, fit: BoxFit.cover),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: SizedBox(
              height: 200.h,
              width: 200.w,
              child: Image.asset("assets/images/Logo.png"),
            ),
          ),
        ),
      ],
    );
  }
}
