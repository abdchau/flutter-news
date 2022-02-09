import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'HackerNews Time',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  MaterialPageRoute routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            StoriesProvider.of(context).fetchTopIds();
            return NewsList();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final itemId = int.parse(settings.name!.substring(1));
            CommentsProvider.of(context).fetchItemWithComments(itemId);

            return NewsDetail(
              itemId: itemId,
            );
          },
        );
    }
  }
}
