import 'package:nations/injector.dart';
import 'package:nations/repository/nations_repository.dart';

abstract class NationsViewContract {
  void onComplete(List list);
  void onError();
}

class NationsPresenter {
  NationsViewContract _view;
  NationsRepositoryContract _repository;

  NationsPresenter(this._view) {
    _repository = new Injector().nationsRepository;
  }

  void loadNations() {
    _repository
        .getNations()
        .then((list) => _view.onComplete(list))
        .catchError((onError) => _view.onError());
  }
}
