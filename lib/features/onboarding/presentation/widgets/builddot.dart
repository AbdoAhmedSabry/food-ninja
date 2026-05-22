import 'package:flutter/material.dart';
import 'package:foodninga/core/colors.dart';

class BuildDot extends StatelessWidget {
  final int index;
  final int currentIndex;
  const BuildDot({super.key, required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? AppColors.primary : Colors.grey.shade300,
      ),
    );
  }
}
