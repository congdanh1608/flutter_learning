import 'dart:async';

import 'package:flutter_learning/views/persistence/provider/file_provider.dart';

class FileBloc {
  final _fileController = StreamController<int>.broadcast();

  get counter => _fileController.stream;

  FileBloc() {
    readCounter();
  }

  dispose() {
    _fileController.close();
  }

  readCounter() async {
    _fileController.sink.add(await FileProvider.fileProvider.readCounter());
  }

  writeCounter(int counter) {
    FileProvider.fileProvider.writeCounter(counter);
    readCounter();
  }
}
