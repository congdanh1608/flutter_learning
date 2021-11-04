import 'dart:async';

import 'package:flutter_learning/db/client.dart';
import 'package:flutter_learning/db/database.dart';

class ClientsBloc {
  ClientsBloc() {
    getClients();
  }

  final clientController = StreamController<List<Client>>.broadcast();

  get clients => clientController.stream;

  dispose() {
    clientController.close();
  }

  getClients() async {
    var clients = await DBProvider.db.getAllClients();
    clientController.sink.add(clients);
  }

  blockUnblock(Client client) {
    DBProvider.db.blockOrUnblock(client);
    getClients();
  }

  delete(int? id) {
    DBProvider.db.deleteClient(id);
    getClients();
  }

  deleteAllClients() {
    DBProvider.db.deleteAllClients();
    getClients();
  }

  add(Client client) {
    DBProvider.db.addNewClient(client);
    getClients();
  }
}
