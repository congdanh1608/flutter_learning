import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_learning/views/networking/post.dart';
import 'package:http/http.dart' as http;

class MyHttp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Fetch'),
            onPressed: () {
              fetchPost().then((response) {
                _showDialog(response.title, response.body, context);
              });
            },
          ),
          RaisedButton(
            child: Text('Authori'),
            onPressed: () {
              fetchAuthorization().then((response) {
                _showDialog(response.title, response.body, context);
              });
            },
          )
        ],
      ),
    );
  }

  _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<Post> fetchPost() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load post');
    }
  }

  Future<Post> fetchAuthorization() async {
    final response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/1',
      headers: {HttpHeaders.authorizationHeader: "Basic 1234_my_token"},
    );

    final responseJson = json.decode(response.body);
    return Post.fromJson(responseJson);
  }
}
