import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodninga/core/textstyle.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white.withValues(alpha: 0.07),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 15.r,
            child: SvgPicture.asset(image, fit: BoxFit.fill),
          ),
          Text(title, style: AppTextStyles.font16BoldWhite),
        ],
      ),
    );
  }
}
