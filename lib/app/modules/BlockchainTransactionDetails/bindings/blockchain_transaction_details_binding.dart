import 'package:get/get.dart';

import '../controllers/blockchain_transaction_details_controller.dart';

class BlockchainTransactionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockchainTransactionDetailsController>(
      () => BlockchainTransactionDetailsController(),
    );
  }
}
