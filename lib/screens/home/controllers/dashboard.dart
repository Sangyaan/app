import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends ChangeNotifier {
  bool? _isDyslexic = false;
  bool? _isDysgraphic = false;
  bool? _isDyscalculic = false;

  bool? get isDyslexic => _isDyslexic;
  bool? get isDysgraphic => _isDysgraphic;
  bool? get isDyscalculic => _isDyscalculic;

  Future<void> getDisorders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDyslexic = prefs.getBool("dyslexic");
    _isDysgraphic = prefs.getBool("dysgraphic");
    _isDyscalculic = prefs.getBool("dyscalculic");
  }
}
