// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/pages/questionView.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  
  String username = '';
  bool avatarSelected = false;
  List<String> avatarImages = [];
  final int totalAvatarsCount = 18;
  int idAvatarSelected = 0;
  double initialOffset = 0.0; // Initialize with the initial offset of the first avatar
  // Define a TextEditingController for the username field
  final TextEditingController _usernameController = TextEditingController();
  ScrollController _gridScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    avatarImages = loadAvatarImages();
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Quizer',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
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
                            'assets/images/avatars/avatar_${idAvatarSelected+1}.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      updateAvatarView(true);
                    },
                    child: const Text('Change Avatar'),
                  ),
                ),
                // Username Text Form Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Username',
                        hintStyle: TextStyle(
                    color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Start Quiz Button
                Visibility (
                  visible: !avatarSelected,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      if (_usernameController.text.isNotEmpty) {
                        username = _usernameController.text;
                        // Navigate to the quiz page with the entered username
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionView(
                              username: username,
                              selectedAvatarId: idAvatarSelected,
                            ),
                          ),
                        );
                      } else {
                        notifyWrongUsername(context);
                      }
                    },
                    child: const Text('Start Quiz'),
                  ),
                ),
              ],
            ),
            
          ),
          Visibility(
            visible: avatarSelected,
            child: Center(
              child: Stack (
                children: [
                  Container (
                    alignment: Alignment.center,
                    width: 300,
                    height: 400,
                    margin: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 15, bottom: 15),
                              child: const Text(
                                'Select an Avatar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                controller: _gridScrollController,
                                padding: EdgeInsets.zero,
                                key: UniqueKey(), // Add a unique key to the GridView.builder
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Adjust the number of columns as needed
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 15.0,
                                ),
                                itemCount: totalAvatarsCount, // Replace with the total number of avatars
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      updateIdAvatar(index, _gridScrollController.offset);
                                    },
                                    child: Container(
                                      decoration: (idAvatarSelected == index) ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 4,
                                        ),
                                        color: const Color.fromARGB(155, 187, 228, 233),// Replace with your avatar background color
                                      ) : BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color.fromARGB(155, 187, 228, 233),// Replace with your avatar background color
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          loadAvatarImages()[index],
                                          width: 50, // Adjust the width as needed
                                          height: 50, // Adjust the height as needed
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30, // Adjust the value to control the button's position
                    left: 0,
                    right: 0,
                    child: Center(
                      child: 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          updateAvatarView(false);
                        },
                        child: const Text('Select Avatar'),
                      ),
                    ),
                  ),
                ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  void notifyWrongUsername(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Please enter a username'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  void updateAvatarView(bool x) {
    setState(() {
      avatarSelected = x;
    });
  }

  List<String> loadAvatarImages() {
    final List<String> avatarImages = [];
    for (var i = 1; i <= totalAvatarsCount; i++) {
      avatarImages.add('assets/images/avatars/avatar_$i.svg');
    }
    return avatarImages;
}

  void updateIdAvatar(int index, double offset) {
    setState(() {
      idAvatarSelected = index;
    });
    
    // Calculate the new initial offset based on the selected avatar's position
    // This calculation depends on your grid layout and avatar size
    initialOffset = offset; // Adjust as needed

    // Set the new initial offset in the ScrollController
    _gridScrollController = ScrollController(initialScrollOffset: initialOffset);

    // Scroll to the selected avatar
    _gridScrollController.animateTo(
      initialOffset,
      duration: const Duration(milliseconds: 0), // Adjust the duration as needed
      curve: Curves.ease, // Adjust the curve as needed
    );
  }

}
