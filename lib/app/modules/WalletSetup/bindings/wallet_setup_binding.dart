import 'package:get/get.dart';

import '../controllers/wallet_setup_controller.dart';

class WalletSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletSetupController>(
      () => WalletSetupController(),
    );
  }
}
