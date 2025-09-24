import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blockchain_transaction_details_controller.dart';

class BlockchainTransactionDetailsView
    extends GetView<BlockchainTransactionDetailsController> {
  const BlockchainTransactionDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlockchainTransactionDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BlockchainTransactionDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
