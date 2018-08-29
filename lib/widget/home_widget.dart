import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nations/bloc/nations_bloc.dart';
import 'package:nations/provider/nations_provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  NationsBloc _bloc;
  bool _networkError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = NationsProvider.of(context);
    _bloc.errors.listen((value) {
      setState(() {
        _networkError = value;
      });
    });
    return new Material(
        color: Colors.blueGrey,
        child: new Scaffold(
            appBar: new AppBar(
              key: new Key('appBar'),
              title: new Text("Nations"),
            ),
            body: _refreshIndicator()));
  }

  Future<Null> _handleRefresh() async {
    _bloc.refresh();
    Completer<Null> completer = new Completer();
    _bloc.isLoading.listen((value) {
      if (!value) completer.complete(null);
    });
    return completer.future;
  }

  Widget _refreshIndicator() {
    return new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: _buildNationsList(),
    );
  }

  Widget _buildNationsList() {
    return new StreamBuilder(
        stream: _bloc.results,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: new Container(
                height: MediaQuery.of(context).size.height,
                child: new Center(
                    child: _networkError
                        ? new Icon(Icons.cloud_off,
                            size: 80.0, color: Colors.grey)
                        : CircularProgressIndicator()),
              ),
            );
          }

          print("list size = ${snapshot.data.length}");

          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                  child: new Container(
                margin: EdgeInsets.all(8.0),
                padding: new EdgeInsets.all(8.0),
                child: new Text(snapshot.data[index],
                    style: new TextStyle(fontSize: 18.0)),
              ));
            },
          );
        });
  }
}
