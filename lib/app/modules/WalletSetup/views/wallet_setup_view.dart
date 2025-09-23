import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_setup_controller.dart';

class WalletSetupView extends GetView<WalletSetupController> {
  const WalletSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletSetupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WalletSetupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
