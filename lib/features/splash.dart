import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodninga/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _patternAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _patternAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0.0, 4.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.30,
            child: SlideTransition(
              position: _patternAnimation,
              child: SvgPicture.asset(
                "assets/images/Pattern.svg",
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),

          SlideTransition(
            position: _logoAnimation,
            child: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/images/Logo.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
