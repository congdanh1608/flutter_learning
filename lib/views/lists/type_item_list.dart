import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTypeList extends StatelessWidget {
  final items = List.generate(
      100,
      (i) => (i % 6 == 0
          ? HeadingItem("Heading $i")
          : MessageItem("Sender $i", "Message $i")));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      ListItem item = items[index];
      if (item is HeadingItem) {
        return ListTile(
          title: Text(
            item.heading,
            style: Theme.of(context).textTheme.title,
          ),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(
            item.sender,
            style: Theme.of(context).textTheme.body1,
          ),
          subtitle: Text(
            item.message,
            style: Theme.of(context).textTheme.body2,
          ),
        );
      }
    });
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String message;

  MessageItem(this.sender, this.message);
}
