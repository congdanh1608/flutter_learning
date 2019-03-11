import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_learning/views/networking/model/photo.dart';
import 'package:http/http.dart' as http;

class MyParsingJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? PhotosList(
                photos: snapshot.data,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
      future: fetchPhotos(),
    ));
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/photos');

    return compute(parsePhotos, response.body);
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  const PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PhotoDetail(photo: photos[index]);
              }));
            },
            child: Image.network(photos[index].thumbnailUrl),
          );
        },
        itemCount: photos.length,
        padding: EdgeInsets.all(0.0),
      ),
    );
  }
}

class PhotoDetail extends StatelessWidget {
  final Photo photo;

  const PhotoDetail({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: FadeInImage.assetNetwork(
            placeholder: 'lib/assets/images/loading.gif',
            image: photo.url,
          ),
        ),
      ),
    );
  }
}
