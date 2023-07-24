import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class LocalStorage {
  String loginTokenKey = 'loginTokenKey';
  String callHistoryKey = 'callHistory';
  String storeCallHistoryCount = "count";

  //SAVE THE LOGIN TOKEN
  Future saveLoginToken(String loginToken) async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString(loginTokenKey, loginToken);
    bearerToken =  loginToken;
  }

  //GET THE LOGIN TOKEN
  Future<String?> getLoginToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(loginTokenKey);
    return token;
  }

  //SAVE THE CALL HISTORY SENT
  Future saveCallHistory(List<Map<String, dynamic>> callHistroy) async {
    List<String> strings = callHistroy.map((m) => jsonEncode(m)).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log(prefs.setStringList(callHistoryKey, strings).toString());
    await prefs.setStringList(callHistoryKey, strings);
  }

  //GET THE CALL HISTORY SENT
  Future<List<Map>> getSavedCallHistory() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    List<String> messagesString =
        sharedPreferences.getStringList(callHistoryKey) ?? [];
    List<Map> messages = [];
    if (messagesString.isNotEmpty) {
      messagesString.forEach((element) {
        messages.add(json.decode(element));
      });
    }
    return messages;
  }

  // SAVE THE CALL HISTORY COUNT SO WE CAN SEND CALL API IF THERE IS CHANGE IN THE LENGTH OF THE LIST
  Future saveCAllHistoryCount(String count) async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString(storeCallHistoryCount, count);
  }

  //GET THE COUNT OF THE CALL HISTORY LIST
  Future<String?> getCount() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final count = sharedPreferences.getString(storeCallHistoryCount);
    return count;
  }
}
