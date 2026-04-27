import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/features/auth/presentation/widgets/logo_container.dart';

class AuthdesignBase extends StatelessWidget {
  const AuthdesignBase({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 370.h,

            child: LogoContainer(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0.h, top: 8.h),
            child: SizedBox(child: child),
          ),
        ],
      ),
    );
  }
}
