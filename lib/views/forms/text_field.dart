import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  @override
  State createState() {
    return MyTextFieldState();
  }
}

class MyTextFieldState extends State<MyTextField> {
  FocusNode focusNode;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please enter a search term',
              ),
              autofocus: true,
              onChanged: (text) {
                print("First text field: $text");
              },
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            TextFormField(
              //use controller to get content
              controller: myController,
              //use focusNode to request the focus
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Enter your username',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        tooltip: 'Focus Second Text Field',
        child: Icon(Icons.edit),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    focusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }
}
