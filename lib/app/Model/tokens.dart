import 'dart:convert';
import 'package:get/get.dart';

TokensResponse tokensResponseFromJson(String str) =>
    TokensResponse.fromJson(json.decode(str));

String tokensResponseToJson(TokensResponse data) => json.encode(data.toJson());

class TokensResponse {
  TokensResponse({
    required this.status,
    required this.message,
    required this.tokens,
  });

  final String status;
  final String message;
  final List<Token> tokens;

  factory TokensResponse.fromJson(Map<String, dynamic> json) => TokensResponse(
    status: json["status"] ?? "",
    message: json["message"] ?? "",
    tokens:
        json["tokens"] == null
            ? []
            : List<Token>.from(
              (json["tokens"] as List).map((x) => Token.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "tokens": List<dynamic>.from(tokens.map((x) => x.toJson())),
  };
}

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
  final RxDouble balance = 0.0.obs;

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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "chain": chain,
      "symbol": symbol,
      "name": name,
      "contract": contract,
      "decimals": decimals,
      "coingecko_id": coingeckoId,
      "enabled_by_default": enabledByDefault,
    };
  }
}
