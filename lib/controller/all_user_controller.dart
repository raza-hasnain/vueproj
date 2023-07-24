import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/utils/local.storage.dart';

import 'package:test_project/model/all_user_model.dart';
import 'package:test_project/utils/const.dart';

class AllUserController extends ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();
  Map<String, dynamic>? responseOfUsers;
  String? loginToken;
  late AllUserModel userModel;

  Future<String?> getloginToken() async {
    loginToken = await _localStorage.getLoginToken();

    return loginToken;
  }

  Future<AllUserModel> getUsersData() async {
    await getloginToken().then((value) {
      loginToken = value;

      notifyListeners();
    });

    try {
      final response = await http.get(Uri.parse(Urls.allUsers), headers: {
        'Authorization': 'Bearer $loginToken',
      });
      log(response.body.toString());

      responseOfUsers = json.decode(response.body);
    } catch (error) {
      log(error.toString());
    } finally {}

    userModel = AllUserModel.fromJson(responseOfUsers!);
    log(userModel.toString());

    return userModel;
  }

  Future getData() async {
    await getUsersData();
    notifyListeners();
  }
}
