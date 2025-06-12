import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/city_data.json");
  }

  Future<Map<String, dynamic>> readJson() async {
    final file = await _localFile;
    if (!await file.exists()) {
      return {};
    }
    final content = await file.readAsString();
    return jsonDecode(content);
  }

  Future<void> writeJson(Map<String, dynamic> data) async {
    final file = await _localFile;
    final jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);
  }
}
