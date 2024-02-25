import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:closetalk/controllers/chat_controller.dart';
import 'package:closetalk/controllers/device_info.dart';
import 'package:closetalk/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class NearbyServiceController extends GetxController {
  var devices = <Device>[].obs;
  late NearbyService nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  final UserController userController = Get.find<UserController>();
  final ChatController chatController = Get.find<ChatController>();

  void triggerNotificationAndCreateUsers(
      List<Device> oldState, List<Device> newState) {
    for (Device oldDevice in oldState) {
      Device? newDevice = newState
          .firstWhereOrNull((device) => device.deviceId == oldDevice.deviceId);
      if (newDevice != null) {
        if ((oldDevice.state == SessionState.notConnected ||
                oldDevice.state == SessionState.connecting) &&
            newDevice.state == SessionState.connected) {
          User user = parseUserInfo(newDevice.deviceName);
          AwesomeNotifications().createNotification(
              content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: 'You are now connected!',
            body: 'You and ${user.name} are now connected.',
          ));
          chatController.checkAndAddNewConversation(user);
        }
      }
    }
  }

  List<User> devicesToUsers(List<Device> devices) {
    List<User> users = [];
    for (var device in devices) {
      User user = parseUserInfo(device.deviceName);
      users.add(user);
    }
    return users;
  }

  Future<void> initializeNearby() async {
    final currentUser = userController.currentUser.value;
    nearbyService = NearbyService();
    String deviceID = '';
    deviceID = await getDeviceInfo();
    final deviceName =
        '$deviceID//${currentUser.name}//${currentUser.introduction}//${currentUser.avatar}';
    await nearbyService.init(
      serviceType: 'closetalk',
      deviceName: deviceName,
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
    subscription = nearbyService.stateChangedSubscription(callback: (devicesList) {
      for (var element in devicesList) {
        debugPrint(
          " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}",
        );
        if (GetPlatform.isAndroid) {
          if (element.state == SessionState.connected) {
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }
      }
      triggerNotificationAndCreateUsers(devices, devicesList);
      devices.clear();
      devices.addAll(devicesList);
      receivedDataSubscription =
          nearbyService.dataReceivedSubscription(callback: (data) async {
        debugPrint(data.toString());
        final parts = parseMessageType(data['message']);
        await performAction(parts[0], parts[1], data['senderDeviceId']);
      });
      update();
    });
  }

  List<String> parseMessageType(String message) {
    List<String> parts = message.split('://');
    return parts;
  }

  Future<void> performAction(String type, String message, String senderId) async {
    switch (type) {
      case 'IND':
        User sender = parseUserInfo(senderId);
        await chatController.addMessageToConversation(message, sender, senderId);
        break;
      default:
        debugPrint('Invalid Type');
    }
  }

  Future<void> disposeResources() async {
    // receivedDataSubscription.cancel();
    subscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    update();
  }
}
