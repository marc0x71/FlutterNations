import 'dart:async';

import 'package:nations/injector.dart';
import 'package:nations/repository/nations_repository.dart';

class NationsBloc {
  NationsRepositoryContract _repository;
  Stream<List<String>> _results = Stream.empty();
  StreamController<bool> _error = StreamController();

  NationsBloc() {
    print("bloc!");
    _repository = new Injector().nationsRepository;
    _error.add(false);

    _results = _repository.getNations().asStream().handleError((error) => _error.add(true));

/*
    _repository.getNations().then((list) {
      _results.add(list as List<String>);
    });*/
  }

  Stream<List<String>> get results => _results;
  Stream<bool> get errors => _error.stream;
}
