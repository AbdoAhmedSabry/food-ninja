import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/pages/test.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';

class SiginupContent extends StatelessWidget {
  const SiginupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Sign Up For Free", style: AppTextStyles.font20BoldWhite),
          SizedBox(height: 30.h),
          CustomTextfield(
            hinttext: "Name",
            prefix: Icon(Icons.person, color: AppColors.primary),
          ),

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

          CustomTextfield(
            hinttext: "Phone",
            prefix: Icon(Icons.phone, color: AppColors.primary),
          ),
          SizedBox(height: 30.h),
          CustomElevetedboutton(
            title: "SiginUp",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
