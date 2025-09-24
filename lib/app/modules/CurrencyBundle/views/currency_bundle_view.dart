import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/currency_bundle_controller.dart';

class CurrencyBundleView extends GetView<CurrencyBundleController> {
  const CurrencyBundleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CurrencyBundleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CurrencyBundleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
