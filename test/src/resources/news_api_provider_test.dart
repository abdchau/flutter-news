import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test("FetchTopIds returns list of ids", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((req) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final topIds = await newsApi.fetchTopIds();
    expect(topIds, [1, 2, 3, 4]);
  });
}
