import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';

class SliderAnimation extends StatelessWidget {
  const SliderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        Slider(
          value: 0.2,
          onChanged: (v) {},
          activeColor: AppColors.primary,
          inactiveColor: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.ac_unit, size: 20.sp, color: Colors.blue),
            SizedBox(width: 5.w),
            Icon(Icons.whatshot, size: 20.sp, color: Colors.red),
          ],
        ),
      ],
    );
  }
}
