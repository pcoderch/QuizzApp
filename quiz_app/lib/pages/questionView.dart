// ignore_for_file: file_names, must_be_immutable, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/model/ProgressBar.dart';
import 'package:quiz_app/model/Question.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();

}

class _QuestionViewState extends State<QuestionView> with SingleTickerProviderStateMixin{
  final List<Question> questions = Question.getQuestions();
  int questionIndex = 0;
  bool hasAnswered = false;
  bool correctAnswer = false;
  int correctAnswers = 0;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
  super.initState();
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3000), // Adjust the animation duration as needed
  );
  _slideAnimation = Tween<Offset>(
    begin: const Offset(0, -1.0), // Start off-screen above
    end: Offset.zero, // End at the original position
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Adjust the animation curve as needed
    ),
  );
}


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay() {
    if (!hasAnswered) {
      return;
    }
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      backgroundColor: Colors.white,
      body: Stack (
        children: [
          Column (
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 330,
              height: 250,
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 248, 248, 250),
              ),
              child: Container(
                margin: const EdgeInsets.all(40),
                child: Image.network(
                  questions[questionIndex].getImageUrl(),
                  width: 150,
                  height: 150
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                questions[questionIndex].getQuestion(),
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5, // Set to 1 for square cells
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: 4, // Number of squares
              itemBuilder: (BuildContext context, int index) {
                // Define colors and text for each square
                final List<Color> colors = [const Color.fromARGB(255, 209, 78, 78), const Color.fromARGB(255, 48, 176, 199), const Color.fromARGB(255, 252, 148, 2), const Color.fromARGB(255, 62, 214, 132)];
                final List<String> texts = [questions[questionIndex].getOptions()[0], questions[questionIndex].getOptions()[1], questions[questionIndex].getOptions()[2], questions[questionIndex].getOptions()[3]];
      
                return GestureDetector(
                  onTap: () {
                    _showOverlay();
                    updateHasAnswered(true);
                    getIfCorrectAnswer(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colors[index],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 10.0,
                        ),
                      ],
                    ), // Set the color based on the index
                    child: Center(
                      child: Text(
                        texts[index], // Set the text based on the index
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
              Visibility(
                visible: hasAnswered,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 62, 214, 132),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 109, 95, 246),
                        offset: Offset(3, 3),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      nextQuestionUpdate();
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
              ),
          ],
        ),
        AnimatedPositioned (
          duration: hasAnswered ? const Duration(milliseconds: 300) : const Duration(milliseconds: 100),
          top: hasAnswered ? 0 : -200,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: correctAnswer ? const Color.fromARGB(255, 62, 214, 132) : const Color.fromARGB(255, 209, 78, 78),
            ),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  correctAnswer ? 'Correct!' : 'Incorrect!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container (
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text (
                      correctAnswer ? 'You got it right!' : 'The correct answer was ${questions[questionIndex].getOptions()[questions[questionIndex].getAnswerIndex()]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        ],
      )
      );
  }

  AppBar appBarMethod() {
    return AppBar(
      title: Container (
        margin: const EdgeInsets.only(right: 50, left: 50),
        child: ProgressBar(
          currentQuestion: questionIndex,
          totalQuestions: questions.length,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 248, 250),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text (
            '${questionIndex + 1}/5', // Use ${} to interpolate values within a string
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Container (
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 248, 250),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SvgPicture.asset(
                  'assets/icons/hintLightBulb.svg',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          )
        ],
      );
  }
  
  void getIfCorrectAnswer(int index) {
    if (index == questions[questionIndex].getAnswerIndex()) {
      print('Correct Answer');
      correctAnswer = true;
      correctAnswers++;
    } else {
      correctAnswer = false;
      print('Wrong Answer');
    }
  }

  void updateHasAnswered(bool x) {
    setState(() {
      hasAnswered = x;
    });
  }
  
  void nextQuestionUpdate() {
    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        hasAnswered = false;
      } else {
        print('Quiz Complete');
        print('Correct Answers: $correctAnswers');
      }
    });
  }


}
