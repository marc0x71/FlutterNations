import 'package:flutter/material.dart';
import 'package:nations/injector.dart';
import 'package:nations/widget/home_widget.dart';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(new MaterialApp(home: new HomeWidget()));
}
