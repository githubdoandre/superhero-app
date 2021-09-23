import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:super_hero/models/hero.dart';
import 'package:super_hero/repository/hero_repository.dart';

enum ResultState {
  LOADED,
  EMPTY,
  IDLE,
  LOADING,
}

enum AppBarState {
  SEARCH,
  IDLE,
}

class HeroBloc extends BlocBase {
  final HeroRepository repository;

  List<HeroModel> _heroList = [];
  List<HeroModel> get results => _heroList;

  final _listController = BehaviorSubject<ResultState>();
  Stream get listStream => _listController.stream;

  final _appBarController = BehaviorSubject<AppBarState>();
  Stream get appBarStream => _appBarController.stream;

  HeroBloc(this.repository);

  Future<void> getList(String filter) async {
    _listController.sink.add(ResultState.LOADING);

    _heroList.clear();

    final result = await repository.getList(filter);
    if (result != null) {
      _heroList.addAll(result);
    }

    if (_heroList.length == 0) {
      _listController.sink.add(ResultState.EMPTY);
    } else {
      _listController.sink.add(ResultState.LOADED);
    }
  }

  void toggleAppBar(AppBarState appBarState) {
    _appBarController.sink.add(appBarState);
  }

  @override
  void dispose() {
    _listController.close();
    _appBarController.close();
    super.dispose();
  }
}
