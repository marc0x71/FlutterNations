import 'dart:async';

import 'package:nations/injector.dart';
import 'package:nations/repository/nations_repository.dart';

class NationsBloc {
  NationsRepositoryContract _repository;
  StreamController<List<String>> _results =
      new StreamController<List<String>>();
  StreamController<bool> _error = StreamController<bool>();
  StreamController<bool> _loading = StreamController<bool>();

  NationsBloc() {
    _repository = new Injector().nationsRepository;
    refresh();
  }

  refresh() {
    _error.add(false);
    _loading.add(true);
    _repository.getNations().then((list) {
      _loading.add(false);
      _results.add(list);
    }).catchError((error) {
      _loading.add(false);
      _results.add(null);
      _error.add(true);
    });
  }

  Stream<List<String>> get results => _results.stream;
  Stream<bool> get errors => _error.stream;
  Stream<bool> get isLoading => _loading.stream;
}
