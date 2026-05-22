import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/admin/presentation/widgets/admin_web_layout.dart';
import 'package:foodninga/features/admin/presentation/widgets/admin_mobile_layout.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Dark theme background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: AppTextStyles.font20BoldWhite.copyWith(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return const AdminWebLayout();
          } else {
            return const AdminMobileLayout();
          }
        },
      ),
    );
  }
}
