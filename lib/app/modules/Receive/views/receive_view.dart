import 'package:credo/app/Utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/receive_controller.dart';

class ReceiveView extends GetView<ReceiveController> {
  const ReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final receiveCtrl = controller;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              LogoBuilder(img: controller.symbols.value, height: 70, width: 70),

              const SizedBox(height: 12),

              Text(
                controller.currency.value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),

              Text(
                controller.symbols.value,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(20),
                child: QrImageView(
                  data: controller.address.value,
                  version: QrVersions.auto,
                  size: 230,
                  embeddedImage: const AssetImage("assets/images/logo.png"),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(70, 70),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              SizedBox(
                width: Get.width / 1.5,
                child: SelectableText(
                  controller.address.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    receiveCtrl.copyAddress();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Copy Address",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
