import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      height: 70.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withOpacity(0.95),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF23C87C).withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home_filled, index: 0, label: "Home"),
          _buildNavItem(icon: Icons.shopping_cart, index: 1, label: "Cart"),
          _buildNavItem(icon: Icons.chat_bubble, index: 2, label: "Chat"),
          _buildNavItem(icon: Icons.person, index: 3, label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 0,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF23C87C).withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF23C87C)
                  : Colors.white.withOpacity(0.4),
              size: 26.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF23C87C),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
