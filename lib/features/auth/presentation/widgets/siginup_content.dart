import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/utils/app_loading_widget.dart';
import 'package:foodninga/core/utils/app_validators.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_cubit.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_state.dart';
import 'package:foodninga/features/auth/presentation/pages/login.dart';
import 'package:foodninga/features/auth/presentation/pages/test.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';

class SiginupContent extends StatefulWidget {
  const SiginupContent({super.key});

  @override
  State<SiginupContent> createState() => _SiginupContentState();
}

class _SiginupContentState extends State<SiginupContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isObscure = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Sign Up For Free", style: AppTextStyles.font20BoldWhite),
            SizedBox(height: 30.h),
            CustomTextfield(
              validator: AppValidators.validateName,
              controller: _nameController,
              hinttext: "Name",
              prefix: Icon(Icons.person, color: AppColors.primary),
            ),

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

            CustomTextfield(
              validator: AppValidators.validatePhone,
              controller: _phoneController,
              hinttext: "Phone",
              prefix: Icon(Icons.phone, color: AppColors.primary),
            ),
            SizedBox(height: 30.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: AppLoadingWidget());
                }
                return CustomElevetedboutton(
                  title: "SiginUp",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().creatEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        name: _nameController.text.trim(),
                        phone: _phoneController.text.trim(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
