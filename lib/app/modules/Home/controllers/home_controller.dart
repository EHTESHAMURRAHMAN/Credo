import 'dart:math';
import 'package:credo/app/Api/Api_Import.dart';
import 'package:credo/app/Api/Base_Api.dart';
import 'package:credo/app/Model/live_price_model.dart';
import 'package:credo/app/Model/tokens.dart';
import 'package:credo/app/Utils/Blockchain_Utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeController extends GetxController {
  final secureStore = Get.find<FlutterSecureStorage>();
  final totalValue = 0.0.obs;
  final tokens = RxList<Token>();
  final livePrices = <String, double>{}.obs;
  final currencyAddress = "".obs;
  ApiImport apiImport = ApiImport();
  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    await getToken();
    await getAddress();
  }

  Future<void> getAddress() async {
    try {
      currencyAddress.value = await secureStore.read(key: 'ETH') ?? '';
      debugPrint("Wallet Address: ${currencyAddress.value}");
    } catch (e) {
      debugPrint('Failed to load address: $e');
    }
  }

  Future<void> getToken() async {
    ApiResponse apiResponse = await apiImport.getTokensApi();
    if (apiResponse.status) {
      TokensResponse response = apiResponse.data;
      tokens.value = response.tokens;
      getPrices();
    }
  }

  Future<void> getPrices() async {
    if (tokens.isEmpty) return;
    try {
      final ids = tokens.map((t) => t.coingeckoId).join(",");
      ApiResponse apiResponse = await apiImport.getLivePriceAPi(ids);

      if (apiResponse.status) {
        PriceResponse priceResponse = apiResponse.data;
        for (var token in tokens) {
          if (priceResponse.prices.containsKey(token.coingeckoId)) {
            token.price.value =
                priceResponse.prices[token.coingeckoId]?.usd ?? 0.0;
          }
        }

        fetchBalances();
      } else {
        debugPrint("Error: ${apiResponse.message}");
      }
    } catch (e) {
      debugPrint("Error fetching prices: $e");
    }
  }

  Future<void> fetchBalances() async {
    if (currencyAddress.value.isEmpty) return;
    for (var token in tokens) {
      try {
        final client = Web3Client(getUrl(token.symbol), Client());
        final address = EthereumAddress.fromHex(currencyAddress.value);

        if (token.contract == null || token.contract!.isEmpty) {
          final balanceAmount = await client.getBalance(address);
          final balanceInEther =
              balanceAmount.getValueInUnit(EtherUnit.ether).toDouble();
          token.balance.value = balanceInEther;
        } else {
          final contractAddress = EthereumAddress.fromHex(token.contract!);

          final abiCode = await rootBundle.loadString('assets/abi/erc20.json');

          final contract = DeployedContract(
            ContractAbi.fromJson(abiCode, "ERC20"),
            contractAddress,
          );

          final balanceFunction = contract.function('balanceOf');
          final result = await client.call(
            contract: contract,
            function: balanceFunction,
            params: [address],
          );

          final balanceInTokens =
              (result.first as BigInt).toDouble() / (pow(10, token.decimals));
          token.balance.value = balanceInTokens;
        }

        debugPrint(
          "Fetched balance for ${token.symbol}: ${token.balance.value}",
        );
      } catch (e) {
        debugPrint("Error fetching balance for ${token.symbol}: $e");
        token.balance.value = 0.0;
      }
    }

    calculateTotalValue();
  }

  void calculateTotalValue() {
    double sum = 0.0;
    for (var token in tokens) {
      sum += token.balance.value;
    }
    totalValue.value = sum;
  }
}
