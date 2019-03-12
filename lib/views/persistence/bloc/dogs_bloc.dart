import 'dart:async';

import 'package:flutter_learning/views/persistence/model/dog.dart';
import 'package:flutter_learning/views/persistence/provider/db_provider.dart';

class DogsBloc {
  //listen to the stream more than once
  final _dogController = StreamController<List<Dog>>.broadcast();

  get dogs => _dogController.stream;

  DogsBloc() {
    getDogs();
  }

  //to avoid memory leaks
  dispose() {
    _dogController.close();
  }

  //to get all dogs from database
  getDogs() async {
    _dogController.sink.add(await DBProvider.db.getDogs());
  }

  delete(int id) {
    DBProvider.db.delete(id);
    getDogs();
  }

  add(Dog dog) {
    DBProvider.db.insertDog(dog);
    getDogs();
  }

  update(Dog dog) {
    DBProvider.db.updateDog(dog);
    getDogs();
  }
}
