import 'package:get/get.dart';

import '../controllers/currency_bundle_controller.dart';

class CurrencyBundleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrencyBundleController>(
      () => CurrencyBundleController(),
    );
  }
}
