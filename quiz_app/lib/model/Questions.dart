// ignore: file_names
class Question {
  final int id;
  final String question;
  final String imageUrl;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.id,
    required this.question,
    required this.imageUrl,
    required this.options,
    required this.answerIndex,
  });
}

  const List sampleData = [
    {
      "id": 1,
      "Question": "What is the capital of India?",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png",
      "options": ['Mumbai', 'Delhi', 'Chennai', 'Kolkata'],
      "answer_index": 1
    },
    {
      "id": 2,
      "Question": "What is the capital of Australia?",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/8/88/Flag_of_Australia_%28converted%29.svg",
      "options": ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      "answer_index": 2
    },
    {
      "id": 3,
      "Question": "What is the capital of USA?",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/a/a4/Flag_of_the_United_States.svg",
      "options": ['New York', 'Washington DC', 'Los Angeles', 'Chicago'],
      "answer_index": 1
    },
    {
      "id": 4,
      "Question": "What is the capital of UK?",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/800px-Flag_of_the_United_Kingdom_%281-2%29.svg.png",
      "options": ['London', 'Manchester', 'Liverpool', 'Birmingham'],
      "answer_index": 0
    },
    {
      "id": 5,
      "Question": "What is the capital of Canada?",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/d/d9/Flag_of_Canada_%28Pantone%29.svg",
      "options": ['Toronto', 'Vancouver', 'Ottawa', 'Montreal'],
      "answer_index": 2
    }
  ];