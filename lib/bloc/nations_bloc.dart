import 'dart:async';

import 'package:nations/injector.dart';
import 'package:nations/repository/nations_repository.dart';
import 'package:rxdart/rxdart.dart';

class NationsBloc {
  NationsRepositoryContract _repository;
  StreamController<List<String>> _results =
      new StreamController<List<String>>();
  PublishSubject<bool> _error = PublishSubject<bool>();
  PublishSubject<bool> _loading = PublishSubject<bool>();

  NationsBloc() {
    _repository = new Injector().nationsRepository;
    refresh();
  }

  refresh() {
    _loading = PublishSubject<bool>();
    _error.add(false);
    _loading.add(true);
    _repository.getNations().then((list) {
      _results.add(list);
    }).whenComplete(() {
      _loading.add(false);
      _loading.close();
    }).catchError((error) {
      _results.add(null);
      _error.add(true);
    });
  }

  Stream<List<String>> get results => _results.stream;
  Stream<bool> get errors => _error.stream;
  Stream<bool> get isLoading => _loading.stream;
}
