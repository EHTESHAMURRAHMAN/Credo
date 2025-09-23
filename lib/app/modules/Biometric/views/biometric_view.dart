import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/biometric_controller.dart';

class BiometricView extends GetView<BiometricController> {
  const BiometricView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiometricView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BiometricView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
