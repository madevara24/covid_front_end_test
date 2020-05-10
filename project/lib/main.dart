import 'package:flutter/material.dart';
import 'package:covid_front_end/pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
  },
));