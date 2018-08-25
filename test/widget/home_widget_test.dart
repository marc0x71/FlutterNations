import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nations/injector.dart';
import 'package:nations/repository/mock_nations_repository.dart';
import 'package:nations/widget/home_widget.dart';

void debugDumpApp() {
  assert(WidgetsBinding.instance != null);
  String mode = 'RELEASE MODE';
  assert(() { mode = 'CHECKED MODE'; return true; }());
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
    await tester.pumpWidget(new MaterialApp(home: new HomeWidget()));
    await tester.pump(new Duration(seconds: 5));

    final Finder cards = find.byType(Card);
    expect(cards, findsNWidgets(4));

    expect(find.text('Italia'), findsOneWidget);    
    expect(find.text('Ungheria'), findsOneWidget);    
    expect(find.text('Francia'), findsOneWidget);    
    expect(find.text('Spagna'), findsOneWidget);    
  });

  testWidgets('In case of error', (WidgetTester tester) async {
    _repository.throwException = true;
    await tester.pumpWidget(new MaterialApp(home: new HomeWidget()));
    await tester.pump(new Duration(seconds: 5));

    final Finder icon = find.byType(Icon);
    expect(icon, findsOneWidget);   

    Icon i = tester.widget(icon);
    expect(i.icon, Icons.cloud_off);
    expect(i.size, 80.0);
    expect(i.color, Colors.grey);
  });
}