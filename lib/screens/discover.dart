import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/constants/icebreakers.dart';
import 'package:closetalk/controllers/chat_controller.dart';
import 'package:closetalk/controllers/nearby_controller.dart';
import 'package:easy_animate/animation/pulse_animation.dart';
import 'package:easy_animate/enum/animate_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:random_avatar/random_avatar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final nearbyServiceController =
      Get.put<NearbyServiceController>(NearbyServiceController());
  final chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    nearbyServiceController.disposeResources();
    super.dispose();
  }

  void init() async {
    await nearbyServiceController.initializeNearby();
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
                GetX<NearbyServiceController>(
                  builder: (_) {
                    final users = _.devicesToUsers(nearbyServiceController.devices);
                    final devices = _.devices;
                    debugPrint(devices.toString());
                    return Center(
                      child: Scatter(
                        fillGaps: true,
                        delegate:
                            FermatSpiralScatterDelegate(ratio: 3.5, a: 1, b: 20),
                        children: List.generate(users.length, (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PulseAnimation(
                                animateType: AnimateType.loop,
                                child: SizedBox(
                                  width: 75,
                                  height: 75,
                                  child: GestureDetector(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: RandomAvatar(users[index].avatar ??
                                          DateTime.now().toIso8601String()),
                                    ),
                                    onTap: () {
                                      _connectToPeer(devices[index]);
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                users[index].name ?? 'Unknown',
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
