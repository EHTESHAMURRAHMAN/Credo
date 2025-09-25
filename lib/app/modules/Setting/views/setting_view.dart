import 'package:credo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SettingView'), centerTitle: true),
      body: Center(
        child: InkWell(
          onTap: () {
            controller.secureStore.deleteAll();
            Get.offAllNamed(Routes.ONBOARDING);
          },
          child: Text(
            'Logout',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
