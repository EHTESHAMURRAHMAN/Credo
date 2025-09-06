import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/receive_controller.dart';

class ReceiveView extends GetView<ReceiveController> {
  const ReceiveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReceiveView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReceiveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
