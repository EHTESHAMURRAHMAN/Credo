import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/recovery_phrase_controller.dart';

class RecoveryPhraseVerificationView extends GetView<RecoveryPhraseController> {
  const RecoveryPhraseVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: backButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Arrange your Secret Recovery Phrase",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Tap words from below to place them in the correct order.",
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: theme.hintColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            /// Error message
            Obx(() {
              if (controller.errorMessage.isEmpty) return const SizedBox();
              return Text(
                controller.errorMessage.value,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.placedWords.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.6,
              ),
              itemBuilder: (context, index) {
                return Obx(() {
                  final word = controller.placedWords[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            word != null ? theme.primaryColor : theme.hintColor,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            word ?? "${index + 1}",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color:
                                  word != null
                                      ? theme.primaryColor
                                      : theme.hintColor,
                            ),
                          ),
                        ),
                        if (word != null)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => controller.removeWord(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 20),

            Text(
              "Tap words below:",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                itemCount: controller.shuffledWords.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final word = controller.shuffledWords[index];
                  return Obx(() {
                    final isPlaced = controller.placedWords.contains(word);
                    return ElevatedButton(
                      onPressed:
                          isPlaced ? null : () => controller.selectWord(word),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(word),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
