// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

class Question {
  int id;
  String question;
  String imageUrl;
  List<String> options;
  int answerIndex;

  Question({
    required this.id,
    required this.question,
    required this.imageUrl,
    required this.options,
    required this.answerIndex,
  });

  String getQuestion() {
    return question;
  }

  String getImageUrl() {
    return imageUrl;
  }

  List<String> getOptions() {
    return options;
  }

  int getAnswerIndex() {
    return answerIndex;
  }

  static List<Question> getQuestions() {
    return sampleData
        .map((question) => Question(
              id: question['id'],
              question: question['Question'],
              imageUrl: question['imageUrl'],
              options: question['options'],
              answerIndex: question['answer_index'],
            ))
        .toList();
  }
}

  List sampleData = [
    {
      "id": 1,
      "Question": "What is the capital of India?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/india/flag-square-250.png",
      "options": ['Mumbai', 'Delhi', 'Chennai', 'Kolkata'],
      "answer_index": 1
    },
    {
      "id": 2,
      "Question": "What is the capital of Australia?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/australia/flag-square-250.png",
      "options": ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      "answer_index": 2
    },
    {
      "id": 3,
      "Question": "What is the capital of USA?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/united-states-of-america/flag-square-250.png",
      "options": ['New York', 'Washington DC', 'Los Angeles', 'Chicago'],
      "answer_index": 1
    },
    {
      "id": 4,
      "Question": "What is the capital of UK?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/united-kingdom/flag-square-250.png",
      "options": ['London', 'Manchester', 'Liverpool', 'Birmingham'],
      "answer_index": 0
    },
    {
      "id": 5,
      "Question": "What is the capital of Canada?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/canada/flag-square-250.png",
      "options": ['Toronto', 'Vancouver', 'Ottawa', 'Montreal'],
      "answer_index": 2
    }
  ];