import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

var timeoutDuration = 90;

Map<String, String> headers = {
  "Content-Type": "application/json;charset=UTF-8",
  "accept": "application/json",
  "Access-Control-Allow-Origin": "*",
  'Charset': 'utf-8',
};
Map<String, String> headers1 = {
  "Content-Type": "application/x-www-form-urlencoded",
};

Future<ApiResponse> get3rdPartyRequestAPI(method) async {
  try {
    String url = '$method';
    if (kDebugMode) {
      print('Get => $url');
    }
    final response = await getRequest(url);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

ApiResponse responseFilter(http.Response response) {
  try {
    if (kDebugMode) {
      print(response.body);
    }
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        if (data is Map) {
          Map map = jsonDecode(response.body);
          if (map['status'] == 'failed') {
            if (map['message'] != null) {
              if (map['message'].toString().toLowerCase().contains('expire')) {
                //Get.offAllNamed(Routes.BIOMATRIC_ACCESS);
              }
            }
            return ApiResponse(
              status: false,
              data: response.body,
              message: map['message'],
            );
          }
        }
        return ApiResponse(status: true, data: response.body, message: SUCCESS);
      case 408:
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Request time out',
        );
      default:
        return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<http.Response> getRequest(String url) async {
  if (kDebugMode) {
    print("Request => $url");
  }

  try {
    if (url.startsWith("assets/")) {
      final jsonStr = await rootBundle.loadString(url);
      return http.Response(jsonStr, 200);
    }

    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(
          Duration(seconds: timeoutDuration),
          onTimeout: () {
            return http.Response('Request time out', 408);
          },
        );
    return response;
  } catch (e) {
    return http.Response('Error: $e', 500);
  }
}

Future<http.Response> postRequest(url, body, {loading = true}) async {
  if (kDebugMode) {
    print('${Uri.parse(url)}\n$body');
  }

  final response = await http
      .post(Uri.parse(url), body: json.encode(body), headers: headers)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
  EasyLoading.dismiss();
  return response;
}

const String SUCCESS = 'success';
const String ERROR = 'failure';

class ApiResponse {
  bool status;
  String message;
  dynamic data;
  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.success(data) {
    return ApiResponse(status: true, message: '', data: data);
  }

  factory ApiResponse.failed(message) {
    return ApiResponse(status: false, message: message, data: null);
  }
}
