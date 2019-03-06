import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: Image.network("https://mocah.org/thumbs/4533609-dog-nature-landscape-terraces-shiba-inu-animals-field.jpg")),
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage, image: "https://mocah.org/uploads/posts/4533751-dog-shiba-inu-animals.jpg"),
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                  placeholder: 'lib/assets/images/loading.gif',
                  image: 'https://mocah.org/uploads/posts/4576922-children-dog-animals-shiba-inu-running.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
