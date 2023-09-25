import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/data/fileManager.dart';
import 'package:quiz_app/model/RankingStat.dart';
import 'package:quiz_app/pages/welcomeScreen.dart'; // Import the RankingStat model

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder<List<RankingStat>>(
        future: FileManager.readRankingFile(), // Read the ranking data from the file
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, display a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data or the data is empty, display a message
            return const Center(child: Text('No leaderboard data available.'));
          } else {
            // If data is available, display the list of RankingStat items
            final rankingList = snapshot.data!;
            return Container (
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromARGB(255, 109, 95, 246),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: const Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 500,
                    child: 
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: rankingList.length,
                        itemBuilder: (context, index) {
                          final ranking = rankingList[index];
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                              title: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          margin: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(200),
                                            color: getRandomColor(index),
                                          ),
                                          child: ClipOval(
                                            child: SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: SvgPicture.asset(
                                                'assets/images/avatars/avatar_${ranking.avatarId + 1}.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          bottom: 40,
                                          top: 40,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              color: const Color.fromARGB(255, 76, 61, 191),
                                            ),
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      ranking.username,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${ranking.score}',
                                      style: const TextStyle(
                                        fontSize: 20, // Adjust the size of the points as needed
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      ' P',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                ),
                ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      child: const Text(
                        'Back to menu',
                        style: TextStyle(fontSize: 18),
                      ),
                  ),
              ],
            ),
          );
        }
      },
    ),
  );
}
}

Color getRandomColor (int index) {
  List<Color> backgroundColors = [
    const Color.fromARGB(255, 212, 149, 90),
    const Color.fromARGB(255, 97, 228, 151),
    const Color.fromARGB(255, 243, 185, 243),
    const Color.fromARGB(255, 141, 136, 221),
    const Color.fromARGB(255, 212, 122, 129),
  ];

  return backgroundColors[index % backgroundColors.length];
}
