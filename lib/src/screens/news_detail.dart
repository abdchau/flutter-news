import 'package:flutter/material.dart';

import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({required this.itemId});

  @override
  Widget build(BuildContext context) {
    CommentsBloc bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithCommentsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          const CircularProgressIndicator();
        }

        return FutureBuilder(
          future: snapshot.data![itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    var children = <Widget>[buildTitle(item)];
    final commentsList = <Comment>[];
    for (int kid in item.kids) {
      commentsList.add(Comment(
        itemId: kid,
        itemMap: itemMap,
        depth: 0,
      ));
    }
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: const EdgeInsets.all(15),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
