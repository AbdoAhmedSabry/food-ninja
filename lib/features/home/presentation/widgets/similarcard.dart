import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/home_state.dart';
import 'package:foodninga/features/home/presentation/widgets/smallcarrdinfo.dart';
import 'package:shimmer/shimmer.dart';

class Similarcard extends StatelessWidget {
  const Similarcard({super.key, required this.product});
  final ProductEntite product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeLoading || state is HomeInitial) {
          return Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.05),
                  highlightColor: Colors.white.withOpacity(0.15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                );
              },
            ),
          );
        }
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeSuccess) {
          final similarProducts = state.products
              .where((element) => element.id != product.id)
              .toList();

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                child: SmallFoodCard(product: similarProducts[index]),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
