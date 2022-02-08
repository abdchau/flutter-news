import 'package:http/http.dart' show Client;
import 'dart:convert' show json;

import '../models/item_model.dart';
import 'repository.dart';

const String _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final res = await client.get(Uri.parse('$_root/topstories.json'));
    final idsList = json.decode(res.body);
    return idsList.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final res = await client.get(Uri.parse('$_root/item/$id.json'));

    return ItemModel.fromJson(json.decode(res.body));
  }
}
