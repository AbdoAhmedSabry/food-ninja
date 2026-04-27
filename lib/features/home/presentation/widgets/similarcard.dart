import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/features/home/presentation/widgets/smallcarrdinfo.dart';

class Similarcard extends StatelessWidget {
  const Similarcard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
          child: SmallFoodCard(),
        );
      },
    );
  }
}
