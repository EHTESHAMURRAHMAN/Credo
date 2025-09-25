import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ReceiveController extends GetxController {
  final argument = Get.arguments;
  final currency = "".obs;
  final address = "".obs;
  final symbols = "".obs;
  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      currency.value = argument["currency"] ?? "";
      address.value = argument["address"] ?? "";
      symbols.value = argument["symbols"] ?? "";
    }
  }

  void copyAddress() {
    if (address.value.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: address.value));
      toast(value: "Wallet address copied to clipboard");
    }
  }
}
