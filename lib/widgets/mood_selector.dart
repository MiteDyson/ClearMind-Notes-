// lib/widgets/mood_selector.dart

import 'package:flutter/material.dart';

class MoodSelector extends StatefulWidget {
  final Function(String) onMoodSelected;

  MoodSelector({required this.onMoodSelected});

  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String selectedMood = 'Neutral';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MoodButton(
          mood: 'Happy',
          color: Colors.yellow,
          isSelected: selectedMood == 'Happy',
          onTap: () {
            setState(() {
              selectedMood = 'Happy';
            });
            widget.onMoodSelected('Happy');
          },
        ),
        MoodButton(
          mood: 'Sad',
          color: Colors.blue,
          isSelected: selectedMood == 'Sad',
          onTap: () {
            setState(() {
              selectedMood = 'Sad';
            });
            widget.onMoodSelected('Sad');
          },
        ),
        MoodButton(
          mood: 'Neutral',
          color: Colors.grey,
          isSelected: selectedMood == 'Neutral',
          onTap: () {
            setState(() {
              selectedMood = 'Neutral';
            });
            widget.onMoodSelected('Neutral');
          },
        ),
      ],
    );
  }
}

class MoodButton extends StatelessWidget {
  final String mood;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  MoodButton({
    required this.mood,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(mood,
            style: TextStyle(color: isSelected ? Colors.black : color)),
      ),
    );
  }
}
