import 'package:credo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final secureStore = Get.find<FlutterSecureStorage>();
  final isUserBlank = "".obs;
  @override
  void onInit() {
    super.onInit();
    check();
  }

  Future check() async {
    try {
      isUserBlank.value = await secureStore.read(key: 'Account 1') ?? '';
      Future.delayed(Duration(seconds: 2), () {
        return isUserBlank.value.isEmpty
            ? Get.offAndToNamed(Routes.ONBOARDING)
            : Get.offAndToNamed(Routes.DASHBOARD);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
