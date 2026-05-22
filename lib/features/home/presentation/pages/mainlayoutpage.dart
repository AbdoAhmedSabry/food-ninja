import 'package:flutter/material.dart';
import 'package:foodninga/features/home/presentation/pages/cartpage.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:foodninga/features/home/presentation/widgets/navigation.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const Center(
      child: Text("Chat", style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text("Profile", style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
