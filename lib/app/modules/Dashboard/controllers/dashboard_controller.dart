import 'package:credo/app/modules/Activity/controllers/activity_controller.dart';
import 'package:credo/app/modules/Activity/views/activity_view.dart';
import 'package:credo/app/modules/Browser/controllers/browser_controller.dart';
import 'package:credo/app/modules/Browser/views/browser_view.dart';
import 'package:credo/app/modules/Home/views/home_view.dart';
import 'package:credo/app/modules/Setting/controllers/setting_controller.dart';
import 'package:credo/app/modules/Setting/views/setting_view.dart';
import 'package:credo/app/modules/Swap/controllers/swap_controller.dart';
import 'package:credo/app/modules/Swap/views/swap_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../Home/controllers/home_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardController extends GetxController {
  final Connectivity connetivity = Connectivity();

  var selectedIndex = 0.obs;
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    _initController(0);
  }

  void changeTab(int index) {
    _disposeController(selectedIndex.value);
    _initController(index);
    selectedIndex.value = index;
  }

  void _initController(int index) {
    switch (index) {
      case 0:
        if (Get.isRegistered<HomeController>()) {
          Get.lazyPut<HomeController>(() => HomeController());
        } else {
          Get.put(HomeController());
        }
        break;
      case 1:
        Get.put(BrowserController());
        break;
      case 2:
        Get.put(SwapController());
        break;
      case 3:
        Get.put(ActivityController());
        break;
      case 4:
        if (Get.isRegistered<SettingController>()) {
          Get.lazyPut<SettingController>(() => SettingController());
        } else {
          Get.put(SettingController());
        }

        break;
    }
  }

  void _disposeController(int index) {
    switch (index) {
      case 0:
        // if (Get.isRegistered<HomeController>()) {
        //   Get.delete<HomeController>();
        // }
        break;
      case 1:
        if (Get.isRegistered<BrowserController>()) {
          Get.delete<BrowserController>();
        }
        break;
      case 2:
        if (Get.isRegistered<SwapController>()) {
          Get.delete<SwapController>();
        }
        break;
      case 3:
        if (Get.isRegistered<ActivityController>()) {
          Get.delete<ActivityController>();
        }
        break;
      case 4:
        if (Get.isRegistered<SettingController>()) {
          Get.delete<SettingController>();
        }
        break;
    }
  }

  Widget getCurrentScreen() {
    switch (selectedIndex.value) {
      case 0:
        return const HomeView();
      case 1:
        return const BrowserView();
      case 2:
        return const SwapView();
      case 3:
        return const ActivityView();
      case 4:
        return const SettingView();
      default:
        return const HomeView();
    }
  }

  Future<bool> handleBackPress() async {
    counter += 1;
    if (counter == 1) {
      Fluttertoast.showToast(msg: 'Press two times to Exit'.tr);
      Future.delayed(const Duration(seconds: 1), () {
        counter = 0;
      });
    }
    return counter >= 2;
  }
}
