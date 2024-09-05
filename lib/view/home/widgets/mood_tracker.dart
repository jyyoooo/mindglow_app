import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindglowequinox/controller/mood_bloc/mood_bloc.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/home/widgets/mood_suggestion_box.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  int? _selectedMoodIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              // color: CupertinoColors.lightBackgroundGray,
              gradient: const LinearGradient(colors: [
                Appcolor.gentleGreen,
                Appcolor.peach,
                Appcolor.softBlue
              ]),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const StyledText(text: 'How are you feeling right now?'),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<MoodBloc>()
                          .add(NewMood(mood: _getImageForMood(index)));
                      setState(() {
                        _selectedMoodIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: _selectedMoodIndex == index
                            ? Border.all(color: Colors.blueAccent, width: 2.0)
                            : null,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/${_getImageForMood(index)}',
                        width: 50, // Adjust size as needed
                        height: 50, // Adjust size as needed
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getImageForMood(int index) {
    switch (index) {
      case 0:
        return 'happyFace.png';
      case 1:
        return 'okayFace.png';
      case 2:
        return 'notGoodFace.png';
      case 3:
        return 'veryBadFace.png';
      default:
        return 'happyFace.png';
    }
  }
}
