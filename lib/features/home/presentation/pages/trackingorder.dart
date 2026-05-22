import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';

class OrderTrackingPage extends StatelessWidget {
  final String orderId;

  const OrderTrackingPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = AppColors.primary;
    const backgroundColor = Color(0xFF0D0D0D);
    const cardColor = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Hot order tracking 🛵",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Center(
              child: Text(
                "an error occurred",
                style: TextStyle(color: Colors.red),
              ),
            );
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryGreen),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                "order not found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;
          String currentStatus = orderData['status'] ?? 'pending';
          String address = orderData['address'] ?? '';
          String totalPrice = orderData['totalPrice']?.toString() ?? '0.0';

          int statusIndex = 0;
          if (currentStatus == 'processing') statusIndex = 1;
          if (currentStatus == 'outForDelivery') statusIndex = 2;
          if (currentStatus == 'delivered') statusIndex = 3;

          return Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "order number : #$orderId",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),
                SizedBox(height: 30.h),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStep(
                          "order placed",
                          "order placed",
                          statusIndex >= 0,
                          false,
                          primaryGreen,
                        ),
                        _buildStep(
                          "preparing",
                          "preparing",
                          statusIndex >= 1,
                          false,
                          primaryGreen,
                        ),
                        _buildStep(
                          "deliverying",
                          "deliverying",
                          statusIndex >= 2,
                          false,
                          primaryGreen,
                        ),
                        _buildStep(
                          "delivered",
                          "delivered",
                          statusIndex >= 3,
                          true,
                          primaryGreen,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "delivered to :",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            address,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "totall price :",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "$totalPrice EGP",
                            style: const TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(
    String title,
    String subtitle,
    bool isDone,
    bool isLast,
    Color accent,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: isDone ? accent : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDone ? accent : Colors.grey,
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 10, color: Colors.black)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 45.h,
                color: isDone ? accent : Colors.grey.withOpacity(0.2),
              ),
          ],
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDone ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDone ? Colors.white60 : Colors.grey.withOpacity(0.5),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
