import 'package:get/get.dart';

class Token {
  final String id;
  final String chain;
  final String symbol;
  final String name;
  final String? contract;
  final int decimals;
  final String coingeckoId;
  final bool enabledByDefault;
  final RxDouble price = 0.0.obs;

  Token({
    required this.id,
    required this.chain,
    required this.symbol,
    required this.name,
    this.contract,
    required this.decimals,
    required this.coingeckoId,
    required this.enabledByDefault,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      chain: json['chain'],
      symbol: json['symbol'],
      name: json['name'],
      contract: json['contract'],
      decimals: json['decimals'],
      coingeckoId: json['coingecko_id'],
      enabledByDefault: json['enabled_by_default'],
    );
  }
}
