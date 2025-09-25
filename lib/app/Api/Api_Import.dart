import 'package:credo/app/Api/Api.dart';
import 'package:credo/app/Api/Api_Path.dart';
import 'package:credo/app/Api/Base_Api.dart';
import 'package:credo/app/Model/Blockchain_Response.dart';
import 'package:credo/app/Model/live_price_model.dart';
import 'package:credo/app/Model/tokens.dart';

class ApiImport extends API {
  @override
  Future<ApiResponse> otherTransaction(url) async {
    ApiResponse apiResponse = await get3rdPartyRequestAPI(url);
    if (apiResponse.status) {
      BlockchainExplorerResponse data = blockchainExplorerResponseFromJson(
        apiResponse.data,
      );
      return ApiResponse.success(data);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getTokensApi() async {
    ApiResponse apiResponse = await get3rdPartyRequestAPI(
      'assets/tokens/tokens.json',
    );
    if (apiResponse.status) {
      TokensResponse data = tokensResponseFromJson(apiResponse.data);
      return ApiResponse.success(data);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getLivePriceAPi(String symbol) async {
    ApiResponse apiResponse = await get3rdPartyRequestAPI(
      '$GET_LIVE_PRICE$symbol&vs_currencies=usd',
    );
    if (apiResponse.status) {
      PriceResponse data = priceResponseFromJson(apiResponse.data);
      return ApiResponse.success(data);
    }
    return ApiResponse.failed(apiResponse.message);
  }
}
