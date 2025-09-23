import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/browser_controller.dart';

class BrowserView extends GetView<BrowserController> {
  const BrowserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BrowserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BrowserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
