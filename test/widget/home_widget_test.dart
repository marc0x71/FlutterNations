import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nations/injector.dart';
import 'package:nations/provider/nations_provider.dart';
import 'package:nations/repository/mock_nations_repository.dart';
import 'package:nations/widget/home_widget.dart';

void debugDumpApp() {
  assert(WidgetsBinding.instance != null);
  String mode = 'RELEASE MODE';
  assert(() {
    mode = 'CHECKED MODE';
    return true;
  }());
  debugPrint('${WidgetsBinding.instance.runtimeType} - $mode');
  if (WidgetsBinding.instance.renderViewElement != null) {
    debugPrint(WidgetsBinding.instance.renderViewElement.toStringDeep());
  } else {
    debugPrint('<no tree currently mounted>');
  }
}

void main() {
  MockNationRepository _repository;

  setUp(() {
    Injector.configure(Flavor.MOCK);
    _repository = new Injector().nationsRepository;
    _repository.throwException = false;
  });

  testWidgets('Success', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new NationsProvider(child: new HomeWidget())));
    await tester.pump(new Duration(seconds: 5));

    final Finder cards = find.byType(Card);
    expect(cards, findsNWidgets(4));

    var list = [];
    cards.evaluate().forEach((element) {
      Card card = element.widget as Card;
      Text text = (card.child as Container).child as Text;
      list.add(text.data);
    });

    expect(list, _repository.nations);
  });

  testWidgets('In case of error', (WidgetTester tester) async {
    _repository.throwException = true;
    await tester.pumpWidget(new MaterialApp(home: new NationsProvider(child: new HomeWidget())));
    await tester.pump(new Duration(seconds: 5));

    final Finder icon = find.byType(Icon);
    expect(icon, findsOneWidget);

    Icon i = tester.widget(icon);
    expect(i.icon, Icons.cloud_off);
    expect(i.size, 80.0);
    expect(i.color, Colors.grey);
  });
}
