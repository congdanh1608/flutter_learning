import 'dart:math';

import 'package:flutter/material.dart';

import '../db/client.dart';
import 'clients_bloc.dart';

class DatabaseScreen extends StatefulWidget {
  DatabaseScreen({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  State<StatefulWidget> createState() {
    return DatabaseScreenState();
  }
}

class DatabaseScreenState extends State<DatabaseScreen> {
  final clientsBloc = ClientsBloc();

  //test clients
  List<Client> testClients = [
    Client("Raouf", "Rahiche", 0),
    Client("Zaki", "oun", 1),
    Client("oussama", "ali", 0),
  ];

  @override
  void dispose() {
    clientsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title!)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    clientsBloc.deleteAllClients();
                  },
                  child: const Text("Clear All")),
              Expanded(
                child: StreamBuilder<List<Client>>(
                  stream: clientsBloc.clients,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Client item = snapshot.data![index];
                              return getRow(item);
                            });
                      } else {
                        return const Center();
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addAClient();
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget getRow(Client client) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          clientsBloc.delete(client.id);
        },
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 465,
              child: GestureDetector(
                onTap: () {
                  print("tap row ${client.id}");
                },
                child: Row(children: [
                  Image.asset('images/ic_ac_unit.png'),
                  Text(
                    "Row ${client.firstName}",
                    style: const TextStyle(fontFamily: 'Avenir-Medium'),
                    maxLines: 2,
                  ),
                ]),
              ),
            )));
  }

  void addAClient() {
    var rng = Random();
    Client client = testClients[rng.nextInt(testClients.length)];
    clientsBloc.add(client);
  }
}
