import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data![itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(itemSnapshot.data!, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel model, BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(model.title),
        subtitle: Text("Score: " + model.score.toString()),
        trailing: Column(
          children: [
            const Icon(Icons.insert_comment_rounded),
            Text(
              model.descendants.toString(),
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, "/${model.id}");
        },
      ),
      const Divider(
        thickness: 2,
      ),
    ]);
  }
}
