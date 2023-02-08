import 'package:digit_predictor/screens/digit_predictor/digit_predictor_screen.dart';
import 'package:digit_predictor/screens/entryPoint/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:digit_predictor/screens/home/home_screen.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeScreen(),
  '/entry-point': (context) => const EntryPoint(),
  '/digit-predictor': (context) => const DigitPredictorScreen(),
};
