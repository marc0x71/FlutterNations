import 'package:nations/injector.dart';
import 'package:nations/presenter/nations_presenter.dart';
import 'package:nations/repository/mock_nations_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockView extends Mock implements NationsViewContract {}

void main() {
  Injector.configure(Flavor.MOCK);
  MockNationRepository repository = new Injector().nationsRepository;
  MockView view = new MockView();
  NationsPresenter presenter = new NationsPresenter(view);

  test("Get nations successfuly", () async {
    repository.throwException = false;
    presenter.loadNations();
    await untilCalled(view.onComplete(repository.nations));
  });
  test("Throw exception", () async {
    repository.throwException = true;
    presenter.loadNations();
    await untilCalled(view.onError());
  });
}
