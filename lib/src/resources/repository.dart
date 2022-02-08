import 'dart:async';

import 'news_db_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  // Repository() {
  //   dbProvider.init();
  // }

  Future<List<int>?>? fetchTopIds() async {
    Source source;
    List<int>? idsList;
    for (source in sources) {
      idsList = await source.fetchTopIds();
      if (idsList != null) {
        return idsList;
      }
    }
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel? item;
    var source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    Cache cache;
    for (cache in caches) {
      if (cache != source) {
        cache.addItem(item!);
      }
    }

    return item!;
  }

  clearCache() async {
    for (Cache cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int>? addItem(ItemModel item);
  Future<int> clear();
}
