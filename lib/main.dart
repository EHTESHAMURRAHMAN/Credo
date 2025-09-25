import 'package:credo/app/Theme/theme.dart';
import 'package:credo/app/routes/app_pages.dart';
import 'package:credo/app_binding.dart';
import 'package:credo/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DenpendencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Credo Wallet',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      initialBinding: AppBinding(),
    );
  }
}
