// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const ProgressBar({super.key, 
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentQuestion / totalQuestions;

    return LinearProgressIndicator(
      value: progress,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow), // Customize the color
      backgroundColor: Colors.grey, // Customize the background color
      minHeight: 8,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
