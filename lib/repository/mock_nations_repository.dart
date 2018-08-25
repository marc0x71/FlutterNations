import 'dart:async';
import 'package:nations/repository/nations_repository.dart';

class MockNationRepository implements NationsRepositoryContract {
  @override
  Future<List> getNations() async {
    List nations = ["Italia", "Ungheria", "Francia", "Spagna"];
    return Future.value(nations);
  }
}
