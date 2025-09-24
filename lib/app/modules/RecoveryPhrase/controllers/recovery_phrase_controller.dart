import 'dart:math';
import 'package:credo/app/routes/app_pages.dart';
import 'package:credo/wallet_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class RecoveryPhraseController extends GetxController {
  final WalletController walletController = WalletController();
  final secureStore = Get.find<FlutterSecureStorage>();
  final mnemonic = ''.obs;
  final isValid = false.obs;
  final seedHex = ''.obs;

  final originalWords = <String>[].obs;
  final shuffledWords = <String>[].obs;
  final placedWords = <String?>[].obs;

  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    generateMnemonic12();
  }

  void generateMnemonic12() {
    final newMnemonic = bip39.generateMnemonic();
    mnemonic.value = newMnemonic;
    isValid.value = bip39.validateMnemonic(newMnemonic);
    seedHex.value = bip39.mnemonicToSeedHex(newMnemonic);

    originalWords.assignAll(newMnemonic.split(" "));

    final shuffled = List<String>.from(originalWords);
    shuffled.shuffle(Random());
    shuffledWords.assignAll(shuffled);

    placedWords.assignAll(List<String?>.filled(originalWords.length, null));
    errorMessage.value = '';
  }

  void selectWord(String word) {
    if (placedWords.contains(word)) return;

    final emptyIndex = placedWords.indexWhere((w) => w == null);
    if (emptyIndex != -1) {
      placedWords[emptyIndex] = word;
    }

    if (!placedWords.contains(null)) {
      verifyPhrase();
    }
  }

  void removeWord(int index) {
    placedWords[index] = null;
    errorMessage.value = '';
  }

  void verifyPhrase() {
    bool success = true;
    for (int i = 0; i < originalWords.length; i++) {
      if (originalWords[i] != placedWords[i]) {
        success = false;
        break;
      }
    }

    if (success) {
      errorMessage.value = '';
      _saveMnemonic(mnemonic.value);

      Get.toNamed(Routes.DASHBOARD);
    } else {
      errorMessage.value = "❌ Incorrect order, please try again.";
    }
  }

  Future<void> _saveMnemonic(String mnemonic) async {
    try {
      await secureStore.write(key: 'Account 1', value: mnemonic);
      walletController.createEthereumWallet(mnemonic);
    } catch (e) {
      errorMessage.value = 'Failed to save mnemonic: $e';
    }
  }
}
