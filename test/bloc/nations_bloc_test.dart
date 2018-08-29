import 'package:nations/bloc/nations_bloc.dart';
import 'package:nations/injector.dart';
import 'package:nations/repository/mock_nations_repository.dart';
import 'package:test/test.dart';

void main() {
  MockNationRepository _repository;
  NationsBloc _bloc;

  setUp(() {
    Injector.configure(Flavor.MOCK);
    _repository = new Injector().nationsRepository;
    _repository.throwException = false;
  });
  test("Get nations successfully", () async {
    _bloc = new NationsBloc();
    _bloc.results.listen((list) {
      expect(list, _repository.nations);
    });    
  });
  test("Throw exception", () async {
    _repository.throwException = true;
    _bloc = new NationsBloc();
  });
}
