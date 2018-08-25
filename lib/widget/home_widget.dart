import 'package:flutter/material.dart';
import 'package:nations/presenter/nations_presenter.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> implements NationsViewContract {
  NationsPresenter _presenter;
  List _data;
  bool _networkError = false;

  HomeWidgetState() {
    _presenter = new NationsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    print("loading...");
    _presenter.loadNations();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.blueGrey,
        child: new Scaffold(
          appBar: new AppBar(
            key: new Key('appBar'),
            title: new Text("Nations"),
          ),
          body: _data != null
              ? _buildNationsList()
              : new Center(
                  child: _networkError
                      ? new Icon(Icons.cloud_off,
                          size: 80.0, color: Colors.grey)
                      : CircularProgressIndicator(),
                ),
        ));
  }

  Widget _buildNationsList() {
    return new ListView.builder(
      itemCount: _data == null ? 0 : _data.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            child: new Container(
          margin: EdgeInsets.all(8.0),
          padding: new EdgeInsets.all(8.0),
          child: new Text(_data[index], style: new TextStyle(fontSize: 18.0)),
        ));
      },
    );
  }

  @override
  void onComplete(List list) {
    print("data loaded");
    this.setState(() {
      _data = list;
    });
  }

  @override
  void onError() {
    print("There is an error");
    this.setState(() {
      _data = null;
      _networkError = true;
    });
  }
}
