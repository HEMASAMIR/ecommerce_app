import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  // Make the methods static
  static Future<void> saveToken(String token) async {
    await storage.write(
      key: "token",
      value: token,
    );
  }

  static Future<String> getToken() async {
    return await storage.read(key: "token") ?? "";
  }

  static Future<void> removeToken() async {
    await storage.delete(key: "token");
  }

  // ✅ حفظ حالة إنهاء الـ OnBoarding
  static Future<void> setOnBoardingDone() async {
    await storage.write(key: "onBoardingDone", value: "true");
  }

  static Future<bool> isOnBoardingDone() async {
    final value = await storage.read(key: "onBoardingDone");
    return value == "true";
  }

  static Future<void> removeOnBoardingFlag() async {
    await storage.delete(key: "onBoardingDone");
  }
}
