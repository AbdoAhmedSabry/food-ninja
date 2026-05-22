import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/di/service_locator.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:foodninga/features/auth/domain/repositories/auth_repo.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_cubit.dart';
import 'package:foodninga/features/auth/presentation/pages/login.dart';
import 'package:foodninga/features/auth/presentation/pages/signup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';
import 'package:foodninga/features/home/presentation/pages/cartpage.dart';
import 'package:foodninga/features/home/presentation/pages/homepage.dart';
import 'package:foodninga/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:foodninga/features/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://psatpmakmanyhqlxclmn.supabase.co',
    anonKey: 'sb_publishable_wivUjy2yPTjoQHMNdR54vw_G-Gw10s0',
  );

  await CacheHelper.init();
  setupServiceLocator();
  runApp(
    DevicePreview(
      enabled: true,
      isToolbarVisible: false,
      builder: (context) => const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt<AuthRepo>())),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              brightness: Brightness.dark,
            ),
            home: const SplashScreen(),
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
          );
        },
      ),
    );
  }
}
