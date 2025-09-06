import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_controller.dart';

class SendView extends GetView<SendController> {
  const SendView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SendView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
