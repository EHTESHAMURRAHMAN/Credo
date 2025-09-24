import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return
    //  PopScope(
    //   canPop: false,
    //   onPopInvokedWithResult: (didPop, result) async {
    //     if (!didPop) {
    //       bool shouldExit = await controller.handleBackPress();
    //       if (shouldExit) {
    //         SystemNavigator.pop();
    //       }
    //     }
    //   },
    //   child:
    Obx(() {
      return Scaffold(
        body: controller.getCurrentScreen(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: Get.theme.primaryColor,
              unselectedItemColor: Get.theme.hintColor,
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeTab,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.home, size: 25),
                  activeIcon: const Icon(CupertinoIcons.home, size: 25),
                  label: 'Home'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.language, size: 25),
                  activeIcon: const Icon(Icons.language, size: 25),
                  label: 'Browser'.tr,
                ),

                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_activity, size: 25),
                  activeIcon: const Icon(Icons.local_activity, size: 25),
                  label: 'Activity'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.settings, size: 25),
                  activeIcon: const Icon(CupertinoIcons.settings, size: 25),
                  label: 'Settings'.tr,
                ),
              ],
            ),
          ),
        ),
      );
    });
    //  );
  }
}
