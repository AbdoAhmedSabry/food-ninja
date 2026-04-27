import 'package:flutter/material.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/features/auth/presentation/widgets/authdesign_base.dart';
import 'package:foodninga/features/auth/presentation/widgets/login_content.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: const AuthdesignBase(child: LoginContent()),
    );
  }
}
