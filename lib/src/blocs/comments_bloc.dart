import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetch = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // getters to streams
  Stream<Map<int, Future<ItemModel>>> get itemWithCommentsStream =>
      _commentsOutput.stream;

  // getters to sinks
  Function(int) get fetchItemWithComments => _commentsFetch.sink.add;

  CommentsBloc() {
    _commentsFetch.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>>? cache, int id, _) {
        cache![id] = _repository.fetchItem(id);

        cache[id]!.then((ItemModel model) {
          for (int kidId in model.kids) {
            fetchItemWithComments(kidId);
          }
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _commentsFetch.close();
    _commentsOutput.close();
  }
}
