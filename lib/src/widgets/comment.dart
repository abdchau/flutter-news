import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId, depth;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({required this.itemId, required this.itemMap, required this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data!;
        var children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: 16.0 * (depth + 1),
              right: 16,
            ),
            title: buildText(item.text),
            subtitle: Text(item.by),
          ),
          const Divider(
            thickness: 1.5,
          ),
        ];
        for (int kid in item.kids) {
          children.add(Comment(
            itemId: kid,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        }

        return Column(
          children: children,
        );
      },
    );
  }

  Text buildText(String text) {
    text = text.compareTo("") == 0 ? "[deleted]" : text;
    text = text
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&#x27', "'");
    return Text(text);
  }
}
