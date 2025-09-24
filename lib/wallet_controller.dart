import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

class WalletController {
  final FlutterSecureStorage secureStore = Get.find<FlutterSecureStorage>();

  Future<String> createEthereumWallet(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final node = bip32.BIP32.fromSeed(Uint8List.fromList(seed));
      String derivationPath = "m/44'/60'/0'/0/0";
      final child = node.derivePath(derivationPath);
      final privateKeyHex = HEX.encode(child.privateKey!);
      final credentials = EthPrivateKey.fromHex(privateKeyHex);
      final address = credentials.address.hexEip55;
      debugPrint('Generated address: $address');

      await saveAddress('ETH', address);
      return address;
    } catch (e) {
      debugPrint('Error generating wallet: $e');
      rethrow;
    }
  }

  Future<void> saveAddress(String symbol, String address) async {
    try {
      await secureStore.write(key: symbol, value: address);
    } catch (e) {
      debugPrint('Error saving address for $symbol: $e');
    }
  }
}
