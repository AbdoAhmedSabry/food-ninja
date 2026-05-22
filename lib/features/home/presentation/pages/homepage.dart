import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/di/service_locator.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:foodninga/features/home/presentation/widgets/cardlist.dart';
import 'package:foodninga/features/home/presentation/widgets/home_title.dart';
import 'package:foodninga/features/home/presentation/widgets/navigation.dart';
import 'package:foodninga/features/home/presentation/widgets/small_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  List<String> categories = ["All", "Burger", "Pizza", "Pasta", "Sushi"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getproducts(),
      child: Scaffold(
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
            child: Column(
              children: [
                HomeHeader(),
                SizedBox(height: 8.h),
                CustomTextfield(
                  height: 77.h,
                  width: 350,
                  hinttext: "What do you want to order?",
                  prefix: Icon(Icons.search, color: AppColors.primary),
                ),

                SizedBox(
                  height: 48.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
                        child: CategoryContainer(
                          title: categories[index],
                          isSelected: selectedCategory == categories[index],
                          onTap: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
                            if (categories[index] == "All") {
                              context.read<HomeCubit>().getproducts();
                            } else {
                              context.read<HomeCubit>().getproductsbycategory(
                                categories[index],
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        child: Text(
                          "Popular Menu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Cardlist(),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
