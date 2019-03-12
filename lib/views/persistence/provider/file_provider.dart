import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileProvider {
  static final FileProvider fileProvider = FileProvider();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<void> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    return int.parse(contents);
  }
}
