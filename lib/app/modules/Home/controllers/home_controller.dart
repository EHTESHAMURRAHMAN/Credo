import 'dart:convert';
import 'package:credo/app/Model/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final secureStore = Get.find<FlutterSecureStorage>();

  final tokens = <Token>[].obs;
  final livePrices = <String, double>{}.obs;
  final address = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    await loadTokens();
    await getAddress();
    await fetchAllPrices();
  }

  Future<void> getAddress() async {
    try {
      address.value = await secureStore.read(key: 'ETH') ?? '';
      debugPrint("Wallet Address: ${address.value}");
    } catch (e) {
      debugPrint('Failed to load address: $e');
    }
  }

  Future<void> loadTokens() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/tokens/tokens.json',
      );
      final data = jsonDecode(jsonString);

      tokens.value =
          (data['tokens'] as List).map((e) => Token.fromJson(e)).toList();

      debugPrint("Loaded tokens: ${tokens.length}");
    } catch (e) {
      debugPrint("Error loading tokens: $e");
    }
  }

  Future<void> fetchAllPrices() async {
    if (tokens.isEmpty) return;

    try {
      final ids = tokens.map((t) => t.coingeckoId).join(",");
      final url =
          "https://api.coingecko.com/api/v3/simple/price?ids=$ids&vs_currencies=usd";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        for (var token in tokens) {
          if (data.containsKey(token.coingeckoId)) {
            token.price.value =
                (data[token.coingeckoId]["usd"] as num).toDouble();
          }
        }
      }
    } catch (e) {
      print("Error fetching prices: $e");
    }
  }
}
