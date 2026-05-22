import 'package:flutter/material.dart';
import 'package:foodninga/core/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  final double size;
  final Color? leftColor;
  final Color? rightColor;

  const AppLoadingWidget({
    super.key,
    this.size = 50.0,
    this.leftColor,
    this.rightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: leftColor ?? AppColors.primary,
        rightDotColor: rightColor ?? const Color(0xFF1A1A1A),
        size: size,
      ),
    );
  }
}
