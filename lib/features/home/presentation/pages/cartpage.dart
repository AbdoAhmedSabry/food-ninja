import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/di/service_locator.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/cart_state.dart';
import 'package:foodninga/features/home/presentation/manager/checkout_cubit.dart';
import 'package:foodninga/features/home/presentation/pages/checkoutpage.dart';
import 'package:foodninga/features/home/presentation/widgets/cartbottembar.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/home/presentation/widgets/cartitem.dart';
import 'package:foodninga/features/home/presentation/widgets/custome_appbar.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, const Color(0xFF23C87C).withOpacity(0.6)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      "My Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final cartcubit = context.read<CartCubit>();

                      if (state is CartLoading) {
                        return ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: AppColors.primary,
                              highlightColor: AppColors.primary.withOpacity(
                                0.5,
                              ),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is CartError) {
                        return Center(child: Text(state.message));
                      } else if (state is CartUpdated) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.cartItems.length,
                                itemBuilder: (context, index) {
                                  return CartItem(cart: state.cartItems[index]);
                                },
                              ),
                            ),
                            Cartbottembar(
                              totalPrice: state.totalPrice,
                              onCheckOutPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          getIt<CheckoutCubit>(),
                                      child: const CheckoutPage(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
