import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/app_images.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/pages/signup.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_social_login.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Sign in Please", style: AppTextStyles.font20BoldWhite),
          SizedBox(height: 10.h),
          CustomTextfield(
            hinttext: "Email",
            prefix: Icon(Icons.email, color: AppColors.primary),
          ),

          CustomTextfield(
            hinttext: "Password",
            prefix: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility, color: AppColors.primary),
            ),
          ),
          SizedBox(height: 10.h),
          Text("Or Continue With", style: AppTextStyles.font14NormalGrey),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 57.h,
                width: 150.w,
                child: SocialLogin(
                  image: AppImages.facebooklogo,
                  title: "Facebook",
                ),
              ),

              SizedBox(
                height: 57.h,
                width: 150.w,
                child: SocialLogin(
                  image: AppImages.googellogo,
                  title: "Google",
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "Forgot Your Password?",

            style: AppTextStyles.font14NormalGrey.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 35.h),
          CustomElevetedboutton(
            title: "LogIn",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
