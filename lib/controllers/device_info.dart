import 'package:closetalk/models/user.dart';
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

// final deviceName = '$deviceID:${currentUser.name}:${currentUser.avatar}';
User parseUserInfo(String deviceName) {
  List<String> values = deviceName.split(':');
  return User(
    id: deviceName,
    name: values[1],
    introduction: '',
    avatar: values[2],
  );
}
