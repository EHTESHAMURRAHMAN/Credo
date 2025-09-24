import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "Credo password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Unlock Credo on this device only.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Create new password", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordHidden.value,
                      onChanged: controller.validatePassword,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  Obx(
                    () =>
                        controller.passwordError.value.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                controller.passwordError.value,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            )
                            : const SizedBox(),
                  ),

                  Obx(
                    () =>
                        controller.passwordStrength.value.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Strength: ${controller.passwordStrength.value}",
                                    style: TextStyle(
                                      color: controller.strengthColor(
                                        controller.passwordStrength.value,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : const SizedBox(),
                  ),

                  const SizedBox(height: 20),
                  Text("Confirm password", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.isConfirmPasswordHidden.value,
                      onChanged: controller.validateConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        controller.confirmPasswordError.value.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                controller.confirmPasswordError.value,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            )
                            : const SizedBox(),
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => CheckboxListTile(
                      value: controller.isTermsAccepted.value,
                      onChanged:
                          (val) =>
                              controller.isTermsAccepted.value = val ?? false,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "I understand that wallet recovery cannot be reset.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed:
                    controller.isTermsAccepted.value
                        ? controller.createPassword
                        : null,
                child: const Text("Create Password"),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
