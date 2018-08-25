import 'package:nations/injector.dart';
import 'package:nations/presenter/nations_presenter.dart';
import 'package:nations/repository/mock_nations_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockView extends Mock implements NationsViewContract {}

void main() {
  MockNationRepository _repository;
  NationsPresenter _presenter;
  MockView _view;

  setUp(() {
    Injector.configure(Flavor.MOCK);
    _repository = new Injector().nationsRepository;
    _view = new MockView();
    _presenter = new NationsPresenter(_view);
    _repository.throwException = false;
  });
  test("Get nations successfully", () async {
    _presenter.loadNations();
    await untilCalled(_view.onComplete(_repository.nations));
  });
  test("Throw exception", () async {
    _repository.throwException = true;
    _presenter.loadNations();
    await untilCalled(_view.onError());
  });
}
