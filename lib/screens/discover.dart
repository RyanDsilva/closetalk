import 'package:closetalk/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userController = Get.put(UserController());
    final List<String> icebreakers = [
      'What\'s your favorite movie/book/TV show?',
      'Do you have a favorite type of cuisine?',
      'What\'s the last song you listened to?',
      'If you could travel anywhere in the world, where would it be and why?',
      'What\'s your most memorable travel experience?',
      'What do you like to do in your free time?',
      'Do you have any favorite hobbies or activities?',
      'What do you enjoy most about your job?',
      'If you could have any job for a day, what would it be?',
      'Have you heard any interesting news lately?',
      'What\'s the most exciting thing happening in your life right now?',
      'If you could have any superpower, what would it be?',
      'If you were stranded on a deserted island, what three things would you bring?',
      'What\'s the last book you read or movie you watched?',
      'If your life was a movie, what would its title be?',
      'Are you more of a morning person or a night owl?',
      'What\'s your most-used app on your phone?',
      'If you could only eat one type of cuisine for the rest of your life, what would it be?',
      'Do you prefer summer or winter activities?',
      'What\'s a goal you\'re currently working towards?',
      'What\'s your fondest memory from school or college?',
      'Did you have any favorite subjects or teachers?',
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            child: Column(
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
                          color: apnaBlack.withOpacity(0.25),
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
                          color: apnaBlack.withOpacity(0.25),
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
                })),
          ),
        ),
      ),
    );
  }
}
