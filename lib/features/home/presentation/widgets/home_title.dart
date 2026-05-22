import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/home_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Text(
                    "Hi ${context.read<HomeCubit>().userName}",
                    style: AppTextStyles.font31BoldWhite.copyWith(
                      fontSize: 24.sp,
                    ),
                  );
                },
              ),
              Text(
                "Find Your Favorite Food",
                style: AppTextStyles.font31BoldWhite.copyWith(fontSize: 18.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
