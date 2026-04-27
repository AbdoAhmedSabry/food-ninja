import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 25),
      height: 60.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_filled, "Home", true),
                _buildNavItem(Icons.person_outline, "Profile", false),
                _buildNavItem(Icons.shopping_cart_outlined, "Cart", false),
                _buildNavItem(Icons.chat_bubble_outline, "Chat", false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected
              ? const Color(0xFF53E88B)
              : Colors.white.withOpacity(0.5),
          size: 28,
        ),
        if (isSelected) SizedBox(height: 4.h),
        if (isSelected)
          Container(
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Color(0xFF53E88B),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
