import 'dart:io';

import 'package:bulls_eye/models/player.dart';
import 'package:path_provider/path_provider.dart';

class HighScoreStorageService {
  final rowDelimiter = "\n";
  final cellDelimiter = ";";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/highscore.txt");
  }

  Future<List<Player>> readHighScore() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();

      return contents.split(rowDelimiter).map((String rowData) {
        List<String> cellData = rowData.split(cellDelimiter);
        return Player(name: cellData[0], streak: int.parse(cellData[0]));
      });
    } catch (e) {
      return [];
    }
  }

  Future<bool> writeHighScore(List<Player> players) async {
    try {
      final file = await _localFile;
      String contents = players.fold("", (String accumulation, Player player) {
        return accumulation + "${player.name}$cellDelimiter${player.streak}$rowDelimiter";
      });
      
      await file.writeAsString(contents);
      return true;
    } catch (e) {
      return false;
    }
  }
}
