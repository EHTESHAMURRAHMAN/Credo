import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  Future<FlutterSecureStorage> secureInit() async {
    return await Get.put(FlutterSecureStorage());
  }
}
