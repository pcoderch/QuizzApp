// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      backgroundColor: const Color.fromARGB(255, 229, 202, 238),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'What is the capital of India?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
              width: 200,
              height: 200,
            ),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1, // Set to 1 for square cells
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: 4, // Number of squares
            itemBuilder: (BuildContext context, int index) {
              // Define colors and text for each square
              final List<Color> colors = [Colors.red, Colors.blue, Colors.orange, Colors.green];
              final List<String> texts = ['Red', 'Blue', 'Orange', 'Green'];

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colors[index],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3, 3),
                      blurRadius: 4.0,
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
              );
            },
          )

        ],
      )
      );
  }

  AppBar appBarMethod() {
    return AppBar(
      title: const Text(
        'Question 1',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 248, 250),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text (
          '1/5',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              //to do HINT BUTTON
            },
            child: Container (
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
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
          )
        ],
      );
  }
}
