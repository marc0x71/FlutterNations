import 'package:nations/repository/nations_repository.dart';
import 'package:test/test.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() {
  MockWebServer _server;
  NationRepository _repository;

  setUp(() async {
    _server = new MockWebServer();
    await _server.start();
    _repository = new NationRepository();
    _repository.serverUrl = _server.url;
  });

  tearDown(() {
    _server.shutdown();
  });

  test("Success", () async {
    _server.enqueue(
        body:
            '{"nations": [{"name": "Afghanistan"},{"name": "Albania"},{"name": "Algeria"},{"name": "Andorra"}]}');
    List list = await _repository.getNations();
    expect(list.length, 4);
    expect(list[0], "Afghanistan");
    expect(list[1], "Albania");
    expect(list[2], "Algeria");
    expect(list[3], "Andorra");
  });
  test("Success with a null", () async {
    _server.enqueue(
        body:
            '{"nations": [null,{"name": "Afghanistan"},{"name": "Albania"},null,{"name": "Algeria"},{"name": "Andorra"}]}');
    List list = await _repository.getNations();
    expect(list.length, 4);
    expect(list[0], "Afghanistan");
    expect(list[1], "Albania");
    expect(list[2], "Algeria");
    expect(list[3], "Andorra");
  });
  test("Server error", () {
    _server.shutdown();
    expect(_repository.getNations(), throwsException);
  });

  test("Invalid json response", () {
    _server.enqueue(
        body:
            '{{"nations": [null,{"name": "Afghanistan"},{"name": "Albania"},null,{"name": "Algeria"},{"name": "Andorra"}]}');
    expect(_repository.getNations(), throwsException);
  });
}
