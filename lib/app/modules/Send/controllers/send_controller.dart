import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendController extends GetxController {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final argument = Get.arguments;
  final currency = "".obs;
  final address = "".obs;
  final icon = "".obs;
  final symbols = "".obs;

  // Selected token, balance, gas fee, and send validity
  final selectedToken = "".obs;
  final balance = 0.0.obs;
  final gasFee = 20.0.obs; // example default gas fee in Gwei
  final isValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (argument != null) {
      currency.value = argument["currency"] ?? "";
      address.value = argument["address"] ?? "";
      icon.value = argument["logo"] ?? "";
      symbols.value = argument["symbols"] ?? "";
    }

    // Example balance
    balance.value = 1.2345;

    // Pre-fill recipient if address exists in arguments
    if (address.value.isNotEmpty) {
      recipientController.text = address.value;
    }

    // Validation triggers on text change
    recipientController.addListener(validateInputs);
    amountController.addListener(validateInputs);
  }

  void validateInputs() {
    final isAddressValid =
        recipientController.text.isNotEmpty &&
        recipientController.text.length == 42 &&
        recipientController.text.startsWith('0x');

    final amount = double.tryParse(amountController.text) ?? 0.0;
    final isAmountValid = amount > 0 && amount <= balance.value;

    isValid.value = isAddressValid && isAmountValid;
  }

  void scanQRCode() {
    // Placeholder: Implement QR code scanning updating recipientController.text
    debugPrint('QR code scan triggered but not implemented.');
  }

  void sendTransaction() {
    // Placeholder: Implement transaction sending logic
    debugPrint('Send transaction triggered.');
  }

  @override
  void onClose() {
    recipientController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
