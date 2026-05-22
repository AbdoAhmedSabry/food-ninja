import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/home/data/models/cartmodel.dart';
import 'package:foodninga/features/home/data/models/ordermodel.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/cart_state.dart';
import 'package:foodninga/features/home/presentation/manager/checkout_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/checkout_state.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:foodninga/features/home/presentation/pages/mainlayoutpage.dart';
import 'package:foodninga/features/home/presentation/pages/trackingorder.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _altPhoneController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _altPhoneController.dispose();
    super.dispose();
  }

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
            colors: [Colors.black, const Color(0xFF23C87C).withOpacity(0.4)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
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
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address *",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextfield(
                        controller: _addressController,
                        hinttext: "Enter your full address...",
                        prefix: Icon(Icons.location_on),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        "Alternative Phone (Optional)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextfield(
                        controller: _altPhoneController,
                        hinttext: "Enter another phone number...",
                        prefix: Icon(Icons.phone_android),
                        inputType: TextInputType.phone,
                      ),

                      SizedBox(height: 24.h),

                      Text(
                        "Payment Method",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: const Color(0xFF23C87C).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: const Color(0xFF23C87C),
                              size: 26.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Cash on Delivery",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF23C87C),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is CheckoutSuccess) {
              context.read<CartCubit>().clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Order Placed Successfully! 🎉"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderTrackingPage(orderId: state.orderId),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return SizedBox(
                width: double.infinity,
                height: 50.h,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF23C87C)),
                ),
              );
            }

            return SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23C87C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                onPressed: () {
                  if (_addressController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter delivery address!"),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  final cartCubit = context.read<CartCubit>();

                  context.read<CheckoutCubit>().placeOrder(
                    items: cartCubit.cartItems.cast<CartModel>(),
                    totalPrice: cartCubit.state is CartUpdated
                        ? (cartCubit.state as CartUpdated).totalPrice
                        : 0.0,
                    address: _addressController.text.trim(),
                    alternativePhone: _altPhoneController.text.trim().isEmpty
                        ? null
                        : _altPhoneController.text.trim(),
                  );
                },
                child: Text(
                  "Confirm Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
