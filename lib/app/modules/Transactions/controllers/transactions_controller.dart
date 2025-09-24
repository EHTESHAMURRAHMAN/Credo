import 'dart:convert';
import 'package:credo/app/Api/Api_Import.dart';
import 'package:credo/app/Api/Base_Api.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Model/Blockchain_Response.dart';
import '../../../Model/xrp_model.dart';
import 'Package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TransactionsController extends GetxController {
  RxList<XRPTransaction> xRPTransaction = <XRPTransaction>[].obs;
  RxBool isLoading = true.obs;

  final blockchainExplorer = RxList<BlockchainExplorer>();
  final isblockchainExplorer = false.obs;
  final address = "".obs;
  final logo = "".obs;
  final currency = "".obs;
  final balance = "".obs;
  final phrase = "".obs;

  final argument = Get.arguments;

  final ApiImport apiImport = ApiImport();
  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      logo.value = argument['logo'];
      address.value = argument['address'];
      currency.value = argument['currency'];
      balance.value = argument['balance'];
    }
    //_loadTransactions();
  }

  DateTime formatDate(String date) {
    DateTime time = DateFormat('MM/dd/yyyy hh:mm:ss').parse(date);
    return time;
  }

  Future<void> fetchBlockchainbalance() async {
    isblockchainExplorer.value = false;

    String contractAddress = "";
    String aPiKey;
    String baseApi;

    switch (currency.value) {
      case 'ETH':
        aPiKey = 'KN11XA92VVWZ14IXNGTSTGFWM94QWXJU84';
        baseApi = 'https://api.etherscan.io/api';
        break;
      case 'BNB':
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'DOGE-BEP20':
        contractAddress = '0xbA2aE424d960c26247Dd6c32edC70B295c744C43';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'XRP-BEP20':
        contractAddress = '0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'USDC-BEP20':
        contractAddress = '0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'USDT-BEP20':
        contractAddress = '0x55d398326f99059ff775485246999027b3197955';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'OKB':
        contractAddress = '0xA27983aB73e4d1905451552C844951C24F7DDd98';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'RONIN':
        contractAddress = '0x6f240911Af540E987154cF5fb75DCa730660FB99';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;
      case 'PEPE-BEP20':
        contractAddress = '0x25d887ce7a35172c62febfd67a1856f20faebb00';
        aPiKey = 'JYIPC1JZPV2M32R6M8FGIREX14VXHCK5T3';
        baseApi = 'https://api.bscscan.com/api';
        break;

      case 'POL':
        contractAddress = '0x0000000000000000000000000000000000001010';
        aPiKey = 'NXXHMN1JPBNUEEFNCX2NY4VX6NDTARXU8B';
        baseApi = 'https://api.polygonscan.com/api';
        break;

      default:
        contractAddress = '0x0000000000000000000000000000000000001010';
        aPiKey = 'NXXHMN1JPBNUEEFNCX2NY4VX6NDTARXU8B';
        baseApi = 'https://api.polygonscan.com/api';
        break;
    }

    final tokenApi =
        '$baseApi?module=account&action=tokentx&'
        'contractaddress=$contractAddress&address=${address.value}&'
        'startblock=0&endblock=99999999&sort=desc&apikey=$aPiKey';
    final bnbApi =
        '$baseApi?module=account&action=txlist&address=${address.value}&startblock=0&endblock=99999999&sort=desc&apikey=$aPiKey';
    final polApi =
        '$baseApi?module=account&action=txlist&address=${address.value}&startblock=0&endblock=99999999&sort=desc&apikey=$aPiKey';
    final ethApi =
        '$baseApi?module=account&action=tokentx&address=${address.value}&startblock=0&endblock=99999999&sort=desc&apikey=$aPiKey';
    try {
      ApiResponse apiresponse = await apiImport.otherTransaction(
        currency.value == 'BNB'
            ? bnbApi
            : currency.value == 'POL'
            ? polApi
            : currency.value == 'ETH'
            ? ethApi
            : tokenApi,
      );
      if (apiresponse.status) {
        BlockchainExplorerResponse response = apiresponse.data;
        blockchainExplorer.value = response.result.toList();
        isblockchainExplorer.value = true;
      } else {
        if (kDebugMode) {
          print("Blockchain API returned an unsuccessful status.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in blockchain API call: $e");
      }
    }
  }

  Future<void> _loadTransactions() async {
    final url = 'https://s1.ripple.com:51234';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "method": "account_tx",
      "params": [
        {
          "account": address.value,
          "ledger_index_min": -1,
          "ledger_index_max": -1,
          "limit": 100,
          "forward": false,
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final fetchedTransactions =
            (jsonMap['result']['transactions'] as List)
                .map(
                  (transactionJson) =>
                      XRPTransaction.fromJson(transactionJson['tx']),
                )
                .toList();

        xRPTransaction.value = fetchedTransactions;
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate1(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  double formatAmount(String amount) {
    return BigInt.parse(amount).toDouble() / 1000000;
  }

  String formatGasFee(String fee) {
    final formatter = NumberFormat('0.#########');
    return formatter.format(int.parse(fee) / 1000000);
  }
}
