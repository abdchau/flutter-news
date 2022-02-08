import 'dart:convert' show jsonDecode, jsonEncode;

class ItemModel {
  final int id, time, parent;
  final bool dead, deleted;
  final String type, by, url;
  final String text, title;
  final List<dynamic> kids;
  final int descendants, score;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        time = parsedJson['time'],
        parent = parsedJson['parent'] ?? 0,
        dead = parsedJson['dead'] ?? false,
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'],
        url = parsedJson['url'],
        text = parsedJson['text'] ?? "",
        title = parsedJson['title'],
        kids = parsedJson['kids'] ?? [],
        descendants = parsedJson['descendants'],
        score = parsedJson['score'];

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        time = parsedJson['time'],
        parent = parsedJson['parent'],
        dead = parsedJson['dead'] == 1,
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        url = parsedJson['url'],
        text = parsedJson['text'],
        title = parsedJson['title'],
        kids = jsonDecode(parsedJson['kids']),
        descendants = parsedJson['descendants'],
        score = parsedJson['score'];

  Map<String, dynamic> toMapforDb() {
    return <String, dynamic>{
      "id": id,
      "time": time,
      "parent": parent,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "url": url,
      "text": text,
      "title": title,
      "kids": jsonEncode(kids),
      "descendants": descendants,
      "score": score,
    };
  }
}
