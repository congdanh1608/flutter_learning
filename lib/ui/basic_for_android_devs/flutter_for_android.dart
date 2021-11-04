import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FlutterForAndroid extends StatefulWidget {
  FlutterForAndroid({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  State<StatefulWidget> createState() {
    return FlutterForAndroidState();
  }
}

class FlutterForAndroidState extends State<FlutterForAndroid> with WidgetsBindingObserver {
  AppLifecycleState? cycleState;
  List? contents = [];
  List<Widget> widgets = [];
  final textFieldController = TextEditingController();
  String? textFieldError;

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    textFieldController.dispose();
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(appLifecycleState) {
    setState(() {
      cycleState = appLifecycleState;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addObserver(this);

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.title!)), body: getBody());
  }

  Widget getRow(int i) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 465,
          child: GestureDetector(
            onTap: () {
              print("tap row $i");
            },
            child: Row(children: [
              Image.asset('images/ic_ac_unit.png'),
              Text(
                "Row ${contents![i]["title"]}",
                style: const TextStyle(fontFamily: 'Avenir-Medium'),
                maxLines: 2,
              ),
            ]),
          ),
        ));
  }

  Widget getBody() {
    bool isShowLoading = contents!.isEmpty;
    if (isShowLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: <Widget>[
          TextField(
              controller: textFieldController,
              decoration: InputDecoration(hintText: "Search...", errorText: textFieldError, contentPadding: const EdgeInsets.all(5))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (textFieldController.text.isEmpty) {
                  textFieldError = 'Empty';
                } else {
                  textFieldError = null;
                  increaseSearchCount();
                }
              });
            },
            child: const Text("Search"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contents!.length,
                itemBuilder: (BuildContext context, int position) {
                  Widget row = getRow(position);
                  widgets.add(row);
                  return row;
                }),
          )
        ],
      );
    }
  }

  Future<void> loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;

    List? msg = await sendReceive(sendPort, 'https://jsonplaceholder.typicode.com/posts');

    setState(() {
      contents = msg;
    });
  }

  static Future<void> dataLoader(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (var msg in receivePort) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataUrl = data;
      http.Response response = await http.get(Uri.parse(dataUrl));
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future sendReceive(SendPort sendPort, msg) {
    ReceivePort receivePort = ReceivePort();
    sendPort.send([msg, receivePort.sendPort]);
    return receivePort.first;
  }

  void increaseSearchCount() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    int counter = shared.getInt("counter") ?? 0;
    print("Current: $counter");
    shared.setInt("counter", counter + 1);
  }
}
