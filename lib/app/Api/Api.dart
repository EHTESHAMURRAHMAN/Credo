import 'package:credo/app/Api/Base_Api.dart';

abstract class API {
  Future<ApiResponse> otherTransaction(url);
  Future<ApiResponse> getTokensApi();
  Future<ApiResponse> getLivePriceAPi(String symbol);
}
