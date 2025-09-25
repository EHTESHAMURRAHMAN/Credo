import 'dart:convert';

PriceResponse priceResponseFromJson(String str) =>
    PriceResponse.fromJson(json.decode(str));

String priceResponseToJson(PriceResponse data) => json.encode(data.toJson());

class PriceResponse {
  final Map<String, TokenPrice> prices;

  PriceResponse({required this.prices});

  factory PriceResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, TokenPrice> pricesMap = {};
    json.forEach((key, value) {
      pricesMap[key] = TokenPrice.fromJson(value);
    });
    return PriceResponse(prices: pricesMap);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    prices.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}

class TokenPrice {
  final double usd;

  TokenPrice({required this.usd});

  factory TokenPrice.fromJson(Map<String, dynamic> json) {
    return TokenPrice(usd: (json["usd"] as num).toDouble());
  }

  Map<String, dynamic> toJson() => {"usd": usd};
}
