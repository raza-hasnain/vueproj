import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/model/lead.model.dart';
import 'package:test_project/utils/local.storage.dart';

import '../utils/const.dart';
import '../view/sales_login.dart';

class Logout extends ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();

  String? loginToken;
  late LeadModel leadModel;


    Future<String?> getloginToken() async {
    loginToken = await _localStorage.getLoginToken();

    return loginToken;
  }

  Future logoutFunc(BuildContext context) async {
    final sharedPreference = await SharedPreferences.getInstance();

     await getloginToken().then((value) {
      loginToken = value;

      notifyListeners();
    });
    try {
      final reponse = await http.post(Uri.parse(Urls.logout), headers: {
        'Authorization': 'Bearer $loginToken',
      });

      sharedPreference.remove('loginTokenKey');

      log(reponse.body.toString());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SalesLogin()));
    } catch (error) {
      log(error.toString());
    } finally {}
  }
}
