import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursProvider with ChangeNotifier {
  List<dynamic> _lesCours = List<dynamic>.empty();
  final String _host = 'https://planning.iae-paris.com/';
  final String _query = 'api/v2/cours?d=';

  CoursProvider();

  List<dynamic> get lesCours => _lesCours;

  void chargerCoursDuJour(String jour) async {
    if (jour != '') {
      String url = _host + _query + jour;
      final Uri uri = Uri.parse(url);

      _lesCours = json.decode(await http.read(uri));
      notifyListeners();
    }
  }
}
