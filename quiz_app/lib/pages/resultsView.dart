// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultsView extends StatelessWidget {
  final String username;
  final int points;
  final int correctAnswers;
  final int totalAnswers;
  final String avatarUrl;

  const ResultsView({
    Key? key,
    required this.username,
    required this.points,
    required this.correctAnswers,
    required this.totalAnswers,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 109, 95, 246),
        child: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200), // Half of the width and height for a circle
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: 200, // Adjust the size as needed
                      height: 200,
                      child: SvgPicture.asset(
                        'assets/images/avatars/$avatarUrl.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Congratulations, $username!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'You scored ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: '$points', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        const TextSpan(text: ' points!'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO: Navigate to LEADERBOARD
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18),
                      ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
