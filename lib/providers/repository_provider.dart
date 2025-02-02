import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_test/entities/repository.dart';
import 'package:http/http.dart' as http;

class RepositoryProvider extends ChangeNotifier {
  List<Repository> _repositories = [];
  List<Repository> get repositories => _repositories;
  bool _incompleteResults = true;
  bool get incompletResults => _incompleteResults;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isPaginating = false;
  bool get isPaginating => _isPaginating;
  fetchRepositories(int page) async {
    Uri url = Uri.parse(
        "https://api.github.com/search/repositories?q=created:%3E${getFormattedDate()}&sort=stars&order=desc&page=$page");
    if (page > 1) {
      _isPaginating = true;
    } else {
      _isLoading = true;
    }
    try {
      notifyListeners();
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        _incompleteResults = data['incomplete_results'];
        List<dynamic> items = data['items'];
        if (page == 1) {
          _repositories = items.map((e) => Repository.fromJson(e)).toList();
        } else {
          _repositories
              .addAll(items.map((e) => Repository.fromJson(e)).toList());
        }
      } else {}
    } catch (e) {
      print("error $e ");
    } finally {
      _isLoading = false;
      _isPaginating = false;
      notifyListeners();
    }
  }

  String getFormattedDate() {
    final DateTime today = DateTime.now();
    final DateTime before30Days = today.subtract(Duration(days: 30));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(before30Days);
  }
}
