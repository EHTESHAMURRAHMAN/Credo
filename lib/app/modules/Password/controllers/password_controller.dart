import 'package:credo/app/Utils/reg_exp.dart';
import 'package:credo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isTermsAccepted = false.obs;

  var passwordError = "".obs;
  var confirmPasswordError = "".obs;
  var passwordStrength = "".obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void validatePassword(String value) {
    final error = PasswordValidator.validate(value);
    passwordError.value = error ?? "";
    passwordStrength.value =
        value.isEmpty ? "" : PasswordValidator.strength(value);

    if (confirmPasswordController.text.isNotEmpty) {
      validateConfirmPassword(confirmPasswordController.text);
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = "Confirm password cannot be empty.";
    } else if (value != passwordController.text) {
      confirmPasswordError.value = "Passwords do not match.";
    } else {
      confirmPasswordError.value = "";
    }
  }

  void createPassword() {
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);

    if (passwordError.value.isEmpty && confirmPasswordError.value.isEmpty) {
      Get.toNamed(Routes.RECOVERY_PHRASE);
    }
  }

  Color strengthColor(String strength) {
    switch (strength) {
      case "Weak":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Strong":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
