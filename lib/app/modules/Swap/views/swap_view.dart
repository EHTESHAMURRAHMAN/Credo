import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/swap_controller.dart';

class SwapView extends GetView<SwapController> {
  const SwapView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwapView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SwapView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
