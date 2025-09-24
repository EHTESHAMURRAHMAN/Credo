import 'package:credo/app/Api/Api.dart';
import 'package:credo/app/Api/Base_Api.dart';
import 'package:credo/app/Model/Blockchain_Response.dart';

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
}
