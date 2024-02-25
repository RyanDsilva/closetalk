import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';

class NearbyServiceController extends GetxController {
  late NearbyService nearbyService;
  late StreamSubscription receivedDataSubscription;

  Future<void> initializeNearby() async {
    nearbyService = NearbyService();
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
    await nearbyService.init(
      serviceType: 'dev_closetalk',
      deviceName: deviceID,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) async {
        if (isRunning) {
          await nearbyService.stopAdvertisingPeer();
          await nearbyService.stopBrowsingForPeers();
          await Future.delayed(const Duration(microseconds: 200));
          await nearbyService.startAdvertisingPeer();
          await nearbyService.startBrowsingForPeers();
        }
      },
    );
  }

  Future<void> disposeResources() async {
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    update();
  }
}
