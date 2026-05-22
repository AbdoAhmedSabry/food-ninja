import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/app_images.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/di/service_locator.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/utils/app_loading_widget.dart';
import 'package:foodninga/core/utils/app_validators.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_cubit.dart';
import 'package:foodninga/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_cubit.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_state.dart';
import 'package:foodninga/features/auth/presentation/pages/forgotpassword.dart';
import 'package:foodninga/features/auth/presentation/pages/signup.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_social_login.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:foodninga/features/home/presentation/pages/mainlayoutpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Sign in Please", style: AppTextStyles.font20BoldWhite),
            SizedBox(height: 10.h),
            CustomTextfield(
              validator: AppValidators.validateEmail,
              controller: _emailController,
              hinttext: "Email",
              prefix: Icon(Icons.email, color: AppColors.primary),
            ),

            CustomTextfield(
              validator: AppValidators.validatePassword,
              controller: _passwordController,
              obscureText: isObscure,
              hinttext: "Password",
              prefix: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
                ),
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

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthGoogleLoading) {
                      return SizedBox(
                        height: 57.h,
                        width: 150.w,
                        child: const AppLoadingWidget(size: 30),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                      child: SizedBox(
                        height: 57.h,
                        width: 150.w,
                        child: SocialLogin(
                          image: AppImages.googellogo,
                          title: "Google",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
              child: Text(
                "Forgot Your Password?",

                style: AppTextStyles.font14NormalGrey.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 35.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  if (state.user.role == 'admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              getIt<AdminCubit>()..getproducts(),
                          child: const AdminDashboardPage(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainLayout(),
                      ),
                    );
                  }
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AuthEmailLoading) {
                  return Center(child: AppLoadingWidget());
                }
                return CustomElevetedboutton(
                  title: "LogIn",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text(
                " i don't have an account? Sign up",

                style: AppTextStyles.font14NormalGrey.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
