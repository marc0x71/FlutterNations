import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class NationsRepositoryContract {
  Future<List> getNations();
}

class NationRepository implements NationsRepositoryContract {
  static const String URL = "https://firetest-dcdb9.firebaseapp.com/";
  String serverUrl;

  NationRepository() {
    serverUrl = URL + "nations.json";
  }

  @override
  Future<List<String>> getNations() async {
    
    var response = await http.get(Uri.decodeFull(serverUrl),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = json.decode(response.body);
    List nations = data["nations"];

    // remove unexpected null items
    List<String> result = [];
    for (int i = 0; i < nations.length; i++) {
      if (nations[i] != null) result.add(nations[i]["name"]);
    }

    return result;
  }
}
