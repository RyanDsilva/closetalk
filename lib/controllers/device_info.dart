import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

Future<String> getDeviceInfo() async {
  String deviceID = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (GetPlatform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceID = androidInfo.model;
  }
  if (GetPlatform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceID = iosInfo.utsname.machine;
  }
  return deviceID;
}
