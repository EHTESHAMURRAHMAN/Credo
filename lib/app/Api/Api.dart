import 'package:credo/app/Api/Base_Api.dart';

abstract class API {
  Future<ApiResponse> otherTransaction(url);
}
