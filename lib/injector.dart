import 'package:nations/repository/mock_nations_repository.dart';
import 'package:nations/repository/nations_repository.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static Flavor _flavor = Flavor.PROD;
  static final Injector _singleton = new Injector._internal();
  NationsRepositoryContract _nationsRepository;
  
  static void configure(Flavor flavor) => _flavor = flavor;

  factory Injector() {
    return _singleton;
  }

  Injector._internal() {
    if (_flavor == Flavor.MOCK) {
      _nationsRepository = new MockNationRepository();
    } else {
      _nationsRepository = new NationRepository();
    }
  }

  NationsRepositoryContract get nationsRepository => _nationsRepository;
}
