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
    },
    {
      "id": 6,
      "Question": "What is the capital of China?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/china/flag-square-250.png",
      "options": ['Shanghai', 'Beijing', 'Hong Kong', 'Shenzhen'],
      "answer_index": 1
    },
    {
      "id": 7,
      "Question": "What is the capital of Japan?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/japan/flag-square-250.png",
      "options": ['Tokyo', 'Osaka', 'Kyoto', 'Yokohama'],
      "answer_index": 0
    },
    {
      "id": 8,
      "Question": "What is the capital of Brazil?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/brazil/flag-square-250.png",
      "options": ['Rio de Janeiro', 'Sao Paulo', 'Brasilia', 'Salvador'],
      "answer_index": 2
    },
    {
      "id": 9,
      "Question": "What is the capital of Russia?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/russia/flag-square-250.png",
      "options": ['Moscow', 'Saint Petersburg', 'Novosibirsk', 'Yekaterinburg'],
      "answer_index": 0
    },
    {
      "id": 10,
      "Question": "What is the capital of France?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/france/flag-square-250.png",
      "options": ['Paris', 'Marseille', 'Lyon', 'Toulouse'],
      "answer_index": 0
    },
    {
      "id": 11,
      "Question": "What is the capital of Germany?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/germany/flag-square-250.png",
      "options": ['Berlin', 'Hamburg', 'Munich', 'Cologne'],
      "answer_index": 0
    },
    {
      "id": 12,
      "Question": "What is the capital of Italy?",
      "imageUrl": "https://cdn.countryflags.com/thumbs/italy/flag-square-250.png",
      "options": ['Rome', 'Milan', 'Naples', 'Turin'],
      "answer_index": 0
    }
  ];