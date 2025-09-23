import 'package:credo/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      return Get.offAndToNamed(Routes.ONBOARDING);
    });
  }
}
