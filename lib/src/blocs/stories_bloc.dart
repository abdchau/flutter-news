import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetch = PublishSubject<int>();

  // getters to streams
  Stream<List<int>> get topIdsStream => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // getters to sinks
  Function(int) get fetchItem => _itemsFetch.sink.add;

  StoriesBloc() {
    _itemsFetch.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>>? cache, int id, _) {
        cache![id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  Future clearCache() {
    return _repository.clearCache();
  }

  void dispose() {
    _topIds.close();
    _itemsFetch.close();
    _itemsOutput.close();
  }
}
