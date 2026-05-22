import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/utils/app_loading_widget.dart';
import 'package:foodninga/core/utils/app_validators.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_cubit.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_state.dart';
import 'package:foodninga/features/auth/presentation/pages/succespageforpassword.dart';
import 'package:foodninga/features/auth/presentation/pages/test.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/auth/presentation/widgets/otpwidget.dart';
import 'package:foodninga/features/auth/presentation/widgets/authdesign_base.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: AuthdesignBase(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                CustomTextfield(
                  validator: AppValidators.validateEmail,
                  controller: _emailController,
                  hinttext: "Email",
                  prefix: Icon(Icons.email, color: AppColors.primary),
                ),
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthPasswordResetEmailSent) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessPageforgot(),
                          ),
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return AppLoadingWidget();
                      }
                      return CustomElevetedboutton(
                        title: "Next",
                        width: double.infinity,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().sendPasswordResetEmail(
                              email: _emailController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
