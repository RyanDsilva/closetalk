import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/constants/icebreakers.dart';
import 'package:closetalk/controllers/nearby_controller.dart';
import 'package:easy_animate/animation/pulse_animation.dart';
import 'package:easy_animate/enum/animate_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Device> devices = [];
  List<Device> connectedDevices = [];
  late StreamSubscription subscription;
  final nearbyServiceController =
      Get.put<NearbyServiceController>(NearbyServiceController());

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    nearbyServiceController.disposeResources();
    subscription.cancel();
    super.dispose();
  }

  void triggerNotificationAndCreateUsers(
      List<Device> oldState, List<Device> newState) {
    for (Device oldDevice in oldState) {
      Device? newDevice = newState
          .firstWhereOrNull((device) => device.deviceId == oldDevice.deviceId);
      if (newDevice != null) {
        if ((oldDevice.state == SessionState.notConnected ||
                oldDevice.state == SessionState.connecting) &&
            newDevice.state == SessionState.connected) {
          debugPrint('Reached Notifications!');
          AwesomeNotifications().createNotification(
              content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: 'You are now connected!',
            body: 'You and ${newDevice.deviceName} are now connected.',
          ));
          // TODO: Create User Chats
        }
      }
    }
  }

  void init() async {
    await nearbyServiceController.initializeNearby();
    subscription = nearbyServiceController.nearbyService.stateChangedSubscription(
        callback: (devicesList) {
      for (var element in devicesList) {
        debugPrint(
          " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}",
        );
        if (GetPlatform.isAndroid) {
          if (element.state == SessionState.connected) {
            nearbyServiceController.nearbyService.stopBrowsingForPeers();
          } else {
            nearbyServiceController.nearbyService.startBrowsingForPeers();
          }
        }
      }
      triggerNotificationAndCreateUsers(devices, devicesList);
      setState(() {
        devices.clear();
        devices.addAll(devicesList);
        connectedDevices.clear();
        connectedDevices.addAll(
            devicesList.where((d) => d.state == SessionState.connected).toList());
      });
    });
  }

  void _connectToPeer(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyServiceController.nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        debugPrint('Connected!');
        break;
      case SessionState.connected:
        break;
      case SessionState.connecting:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userController = Get.put(UserController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: apnaWhite,
        key: const Key('discover'),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx < -sensitivity) {
              // Left
              Get.offAndToNamed('/');
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(icebreakers.length, (i) {
                    if (i % 2 == 0) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Marquee(
                          text: icebreakers[i],
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                            color: apnaBlack.withOpacity(0.35),
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 10.0,
                          velocity: 25.0,
                          pauseAfterRound: const Duration(seconds: 0),
                          startPadding: 10.0,
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Marquee(
                          text: icebreakers[i],
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                            color: apnaBlack.withOpacity(0.35),
                          ),
                          textDirection: TextDirection.rtl,
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 10.0,
                          velocity: 25.0,
                          pauseAfterRound: const Duration(seconds: 0),
                          startPadding: 10.0,
                        ),
                      );
                    }
                  }),
                ),
                Center(
                  child: Scatter(
                    fillGaps: true,
                    delegate: FermatSpiralScatterDelegate(ratio: 3.5, a: 1, b: 20),
                    children: List.generate(devices.length, (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PulseAnimation(
                            animateType: AnimateType.loop,
                            child: Container(
                              width: 75,
                              height: 75,
                              decoration: const BoxDecoration(
                                color: apnaMaroon,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: apnaMaroon,
                                onTap: () {
                                  _connectToPeer(devices[index]);
                                },
                              ),
                            ),
                          ),
                          Text(
                            devices[index].deviceName,
                            style: const TextStyle(
                              color: apnaMaroon,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
