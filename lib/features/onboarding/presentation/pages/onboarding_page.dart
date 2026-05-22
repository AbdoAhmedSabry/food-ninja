import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/features/auth/presentation/pages/login.dart';
import 'package:foodninga/features/auth/presentation/widgets/logo_container.dart';
import 'package:foodninga/features/onboarding/data/models/onboardingmodel.dart';
import 'package:foodninga/features/onboarding/presentation/widgets/builddot.dart';
import 'package:foodninga/features/onboarding/presentation/widgets/onboarding_base.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> screens = [
    OnboardingModel(
      lottieImage: 'assets/lottie/Food Market App Interaction.json',
      description: 'Welcome to our app, a new and easy experience.',
    ),
    OnboardingModel(
      lottieImage: 'assets/lottie/Food squeeze_With Burger and hot dog.json',
      description:
          'You can follow all your orders and know their status first-hand.',
    ),
    OnboardingModel(
      lottieImage: 'assets/lottie/Man riding a red scooter.json',
      description: 'Lets start and explore all the features together!',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(width: double.infinity, child: LogoContainer()),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: screens.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingWidget(
                  lottieImage: screens[index].lottieImage,
                  description: screens[index].description,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    screens.length,
                    (index) =>
                        BuildDot(index: index, currentIndex: currentIndex),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (currentIndex == screens.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text(
                    currentIndex == screens.length - 1 ? 'Start' : 'Next',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
