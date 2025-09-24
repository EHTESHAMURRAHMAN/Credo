import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:credo/app/modules/RecoveryPhrase/views/recovery_phrase_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recovery_phrase_controller.dart';

class RecoveryPhraseView extends GetView<RecoveryPhraseController> {
  const RecoveryPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, leading: backButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Save your Secret Recovery Phrase',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "This is your Secret Recovery Phrase. Write it down in the correct order and keep it safe. "
                      "If someone has your Secret Recovery Phrase, they can access your wallet. "
                      "Don't share it with anyone, ever.",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: theme.hintColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 25),

                    Obx(() {
                      final words = controller.mnemonic.value.split(" ");
                      return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Get.theme.canvasColor,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: words.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2.5,
                              ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: theme.highlightColor),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 9,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${index + 1}.",
                                    style: GoogleFonts.roboto(fontSize: 14),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      words[index],
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(
                height: 55,
                width: Size.infinite.width,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    Get.to(RecoveryPhraseVerificationView());
                  },
                  label: const Text("Continue"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
