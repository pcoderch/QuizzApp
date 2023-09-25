// ignore_for_file: file_names, must_be_immutable, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/data/fileManager.dart';
import 'package:quiz_app/model/ProgressBar.dart';
import 'package:quiz_app/model/Question.dart';
import 'package:quiz_app/model/RankingStat.dart';
import 'dart:math';

import 'package:quiz_app/pages/resultsView.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key, required this.username, required this.selectedAvatarId}) : super(key: key);
  final String username;
  final int selectedAvatarId;

  @override
  // ignore: no_logic_in_create_state
  _QuestionViewState createState() => _QuestionViewState(username: username, selectedAvatarId: selectedAvatarId);
}

class _QuestionViewState extends State<QuestionView> with SingleTickerProviderStateMixin{
  final List<Question> questions = Question.getQuestions();
  int questionIndex = 0;
  bool hasAnswered = false;
  bool correctAnswer = false;
  int quizPoints = 0;
  int countCorrectAnswers = 0;
  List<int> hintAnswers = [];
  bool hintActivated = false;
  String username = '';
  int selectedAvatarId = 0;

  _QuestionViewState({required String username, required int selectedAvatarId}) {
    // ignore: prefer_initializing_formals
    this.username = username;
    // ignore: prefer_initializing_formals
    this.selectedAvatarId = selectedAvatarId;
  }

  late AnimationController _animationController;
  // ignore: unused_field
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
      body: bodyMethod()
    );
  }

  Stack bodyMethod() {
    return Stack (
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
              final List<Color> colors = [const Color.fromARGB(255, 229, 133, 133), const Color.fromARGB(255, 48, 176, 199), const Color.fromARGB(255, 252, 148, 2), const Color.fromARGB(255, 62, 214, 132)];
              final List<String> texts = [questions[questionIndex].getOptions()[0], questions[questionIndex].getOptions()[1], questions[questionIndex].getOptions()[2], questions[questionIndex].getOptions()[3]];
    
              return GestureDetector(
                onTap: () {
                  if (hasAnswered) {
                    return;
                  } else {
                    _showOverlay();
                    updateHasAnswered(true);
                    getIfCorrectAnswer(index);
                  }
                },
                child: Stack(
                  children: [ 
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: hasAnswered ? ((questions[questionIndex].answerIndex != index) ? const Color.fromARGB(255, 209, 78, 78): const Color.fromARGB(255, 62, 214, 132))//Has answered true
                      : hintActivated ? ((hintAnswers.contains(index)) ? const Color.fromARGB(255, 209, 78, 78):colors[index]) : colors[index], //has answered false
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
                  Positioned (
                    //top right position
                    top: 0,
                    right: 0,
                    child: Visibility(
                      visible: hasAnswered || (hintActivated && hintAnswers.contains(index)),
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        child: SvgPicture.asset(
                          (questions[questionIndex].answerIndex == index) ? 'assets/icons/correct.svg' : 'assets/icons/incorrect.svg',
                          width: 35,
                          height: 35,
                          // ignore: deprecated_member_use
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  ],
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
                  child: Text(
                    (questionIndex+1 < questions.length) ? 'Next' : 'Finish',
                    style: const TextStyle(fontSize: 18),
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
                margin: const EdgeInsets.only(top: 30, right: 80, left: 80),
                decoration: BoxDecoration (
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 248, 248, 250),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text (
                    correctAnswer ? '400+ point' : 'That was close',
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
    );
  }

  AppBar appBarMethod() {
    return AppBar(
      title: Container (
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 50, left: 50),
        child: ProgressBar(
          currentQuestion: questionIndex+1,
          totalQuestions: questions.length,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 3),
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 248, 250),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text (
            '${questionIndex + 1}/${questions.length}', // Use ${} to interpolate values within a string
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
                hintActivated ? null : activateHint();
              },
              child: Container (
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 248, 250),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: hintActivated ? SvgPicture.asset(
                  'assets/icons/hintBlackLightBulb.svg',
                  width: 40,
                  height: 40,
                ) : SvgPicture.asset(
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
      quizPoints += 400;
      countCorrectAnswers++;
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
    print(questionIndex);
    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        hasAnswered = false;
        hintActivated = false;
        hintAnswers = [];
      } else {
        print('Quiz Complete');
        print('Total quiz points: $quizPoints');
        finishQuiz();
      }
    });
  }

  void activateHint() {
    setState(() {
      hintActivated = true;
      while (hintAnswers.length < 2) {
        final int randomIndex = Random().nextInt(questions[questionIndex].getOptions().length);
        if (!hintAnswers.contains(randomIndex) && randomIndex != questions[questionIndex].getAnswerIndex()) {
          hintAnswers.add(randomIndex);
        }
      }
    });
  }
  
  void finishQuiz() {

    bool newHighScore = false;

    FileManager.readRankingFile().then((rankingList) {
      if (rankingList.isEmpty) {
        rankingList.add(RankingStat(username: username, score: quizPoints, avatarId: selectedAvatarId));
        rankingList.sort((a, b) => b.score.compareTo(a.score)); //sort the list
        FileManager.writeRankingFile(rankingList); //write the list
        return;
      } else {
        for (int i = 0; i < rankingList.length; i++) {
          if (rankingList[i].getUsername() == username) {
            if (rankingList[i].getScore() < quizPoints) {
              newHighScore = true;
              rankingList[i].setScore(quizPoints);
              rankingList[i].setAvatarId(selectedAvatarId);
            }
            rankingList.sort((a, b) => b.score.compareTo(a.score)); //sort the list
            FileManager.writeRankingFile(rankingList); //write the list
            return;
          }
        }
        rankingList.add(RankingStat(username: username, score: quizPoints, avatarId: selectedAvatarId));
        rankingList.sort((a, b) => b.score.compareTo(a.score)); //sort the list
        FileManager.writeRankingFile(rankingList); //write the list
      }
    });

    Navigator.push(context
      , MaterialPageRoute(
        builder: (context) => ResultsView(
          username: username,
          points: quizPoints,
          correctAnswers: countCorrectAnswers,
          totalAnswers: questions.length,
          avatarUrl: 'avatar_${selectedAvatarId+1}',
          newHighScore: newHighScore
        ),
      ),
    );  
  }


}
