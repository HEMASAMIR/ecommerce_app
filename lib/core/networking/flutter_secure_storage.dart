import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String> getToken() async {
    final token = await storage.read(key: 'token');
    log('From StorageHelper => token: $token');
    return token ?? '';
  }

  static Future<void> removeToken() async {
    await storage.delete(key: "token");
    log('Token removed');
  }

  static Future<void> setOnBoardingDone() async {
    await storage.write(key: "onBoardingDone", value: "true");
  }

  static Future<bool> isOnBoardingDone() async {
    final value = await storage.read(key: "onBoardingDone");
    return value == "true";
  }

  static Future<void> removeOnBoardingDone() async {
    await storage.delete(key: "onBoardingDone");
    log('OnBoarding flag removed');
  }
}
