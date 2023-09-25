import 'package:quiz_app/model/RankingStat.dart';
import 'dart:convert'; // for json decoding
import 'dart:io'; // for writing files
import 'package:path_provider/path_provider.dart';


class FileManager {

  static Future<List<RankingStat>> readRankingFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/leaderboard.json');

      // Read the JSON string from the file
      final jsonString = await file.readAsString();

      // Check if the JSON data is empty
      if (jsonString.isEmpty) {
        print('The ranking JSON file is empty.');
        return []; // Return an empty list
      }

      // Parse the JSON string into a list of RankingStat objects
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<RankingStat> rankingList = jsonList
          .map((json) => RankingStat.fromJson(json))
          .toList();

      return rankingList;
    } catch (e) {
      print('Error reading ranking file: $e');
      return []; // Return an empty list in case of an error
    }
  }


  // Function to write ranking data to a JSON file
  static Future<void> writeRankingFile(List<RankingStat> rankingList) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/leaderboard.json');

      // Convert the list of RankingStat objects to a list of JSON maps
      final jsonList = rankingList.map((ranking) => ranking.toJson()).toList();

      // Encode the list as a JSON string
      final jsonString = json.encode(jsonList);

      // Write the JSON string to the file
      await file.writeAsString(jsonString);

      print('Ranking file updated successfully.');
    } catch (e) {
      print('Error writing ranking file: $e');
    }
  }




    
}