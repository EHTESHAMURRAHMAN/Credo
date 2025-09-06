import 'package:credo/app/Theme/theme.dart';
import 'package:credo/app/routes/app_pages.dart';
import 'package:credo/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tixcash Chain Mall',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      initialBinding: AppBinding(),
    );
  }
}
