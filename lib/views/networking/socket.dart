import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MySocket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySocketState();
  }
}

class _MySocketState extends State<MySocket> {
  final _formState = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  WebSocketChannel channel;

  @override
  Future initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    /*channel.stream.listen((receivedMessage) {
      print(receivedMessage);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Form(
                key: _formState,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text!';
                    }
                  },
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send a message'),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  _sendMessage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.white, width: 1.0),
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.send),
                ),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _sendMessage() {
    if (_formState.currentState.validate()) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
