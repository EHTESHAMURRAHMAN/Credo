import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class RecoveryPhraseController extends GetxController {
  // simple counter you had
  final count = 0.obs;

  // observable mnemonic (12 words)
  final mnemonic = ''.obs;

  // whether the current mnemonic is valid
  final isValid = false.obs;

  // seed (hex) derived from mnemonic
  final seedHex = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // generate a 12-word mnemonic when controller initializes
    generateMnemonic12();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Generates a 12-word BIP39 mnemonic (128 bits of entropy)
  void generateMnemonic12() {
    // bip39.generateMnemonic() with default strength 128 produces 12 words
    final newMnemonic = bip39.generateMnemonic(); // strength=128 by default
    mnemonic.value = newMnemonic;
    isValid.value = bip39.validateMnemonic(newMnemonic);
    seedHex.value = bip39.mnemonicToSeedHex(newMnemonic);
  }

  /// Validate a given mnemonic string and update observables
  void setMnemonic(String m) {
    mnemonic.value = m.trim();
    isValid.value = bip39.validateMnemonic(mnemonic.value);
    seedHex.value =
        isValid.value ? bip39.mnemonicToSeedHex(mnemonic.value) : '';
  }

  /// Copy mnemonic to clipboard
  Future<void> copyMnemonicToClipboard() async {
    if (mnemonic.value.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: mnemonic.value));
    Get.snackbar(
      'Copied',
      'Recovery phrase copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Get seed as bytes (if you prefer bytes instead of hex)
  List<int> getSeedBytes() {
    // bip39.mnemonicToSeed returns Uint8List (depends on implementation)
    final seed = bip39.mnemonicToSeed(mnemonic.value);
    return seed;
  }

  void increment() => count.value++;
}
