import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/home/domain/entities/cartentitie.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cart});
  final CartEntitie cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              color: Colors.white.withOpacity(0.05),
              child: Image.network(
                cart.product.imageurl,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cart.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font16BoldWhite,
                ),
                SizedBox(height: 4.h),
                Text(
                  "\$${cart.product.price}",
                  style: AppTextStyles.font14MediumWhite24.copyWith(
                    color: const Color(0xFF23C87C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              _buildCounterButton(Icons.remove, () {
                context.read<CartCubit>().removeFromCart(cart.product);
              }),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "${cart.quantity}",
                  style: AppTextStyles.font16BoldWhite,
                ),
              ),

              _buildCounterButton(Icons.add, () {
                context.read<CartCubit>().addToCart(cart.product);
              }),

              SizedBox(width: 5.w),

              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 22,
                ),
                onPressed: () {
                  context.read<CartCubit>().deleteProduct(cart.product);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
