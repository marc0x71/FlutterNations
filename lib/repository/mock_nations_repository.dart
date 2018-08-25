import 'dart:async';
import 'package:nations/repository/nations_repository.dart';

class MockNationRepository implements NationsRepositoryContract {
  List nations = ["Italia", "Ungheria", "Francia", "Spagna"];
  bool throwException = false;

  @override
  Future<List> getNations() async {
    if (throwException) throw new Exception("Fault");
    return Future.value(nations);
  }
}
