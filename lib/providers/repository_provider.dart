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
  bool get isLoading => _incompleteResults;
  fetchRepositories(int page) async {
    _isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://api.github.com/search/repositories?q=created:%3E${getFormattedDate()}&sort=stars&order=desc&page=$page");
    try {
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
      notifyListeners();
    }
  }

  String getFormattedDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
