import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/home_state.dart';
import 'package:foodninga/features/home/presentation/widgets/cardinfo.dart';
import 'package:shimmer/shimmer.dart';

class Cardlist extends StatelessWidget {
  const Cardlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeLoading || state is HomeInitial) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.white.withValues(alpha: 0.05),
                highlightColor: Colors.white.withValues(alpha: 0.15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              );
            },
          );
        }

        if (state is HomeSuccess) {
          if (state.products.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Text(
                  'No products found in this category.',
                  style: AppTextStyles.font14MediumWhite24,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 0.73,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return CardInfo(product: product);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
