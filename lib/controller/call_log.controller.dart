import 'dart:convert';
import 'dart:developer';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test_project/components/snackbar.dart';
import 'package:test_project/utils/global.util.dart';
import '../utils/const.dart';

class CallLogController extends ChangeNotifier {
  List<CallLogEntry> entries = [];
  List<Map<String, dynamic>> callLogsList = [];
  final selectedIndexes = [];
  bool isLoading = false;
  late Map<String, dynamic> responseLogs;

  List<CallLogEntry> callLogs = [];
  DateTime? date;

  List<Map<String, dynamic>> dataDatesToDelete = [];
  List<Map<String, dynamic>?> getTheSavedList = [];
  List<Map<String, dynamic>> forCompare = [];
  List<Map<String, dynamic>> todayCalls = [];
  List<Map<String, dynamic>> yesterdayCalls = [];
  List<Map<String, dynamic>> olderCalls = [];
  List<Map<String, dynamic>> allCallData = [];

  selectContact(String index, String? number, String? timestamp, int? duration,
      String status, BuildContext context) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      callLogsList.removeWhere((item) => item.containsValue("$timestamp"));
    } else {
      callLogsList.add({
        "leadContact": number.toString(),
        'dateTime': timestamp.toString(),
        'duration': duration.toString(),
        'status': status
      });
      selectedIndexes.add(index);
    }

    notifyListeners();
  }

  savingForCompare(int index, String? number, String? timestamp, int? duration,
      String status, BuildContext context) {
    forCompare.add({
      "leadContact": number.toString(),
      'dateTime': timestamp.toString(),
      'duration': duration.toString(),
      'status': status
    });
  }

  Future callLogApi(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var list = json.encode(callLogsList);
      final reponse = await http.post(Uri.parse(Urls.callLogs),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer $bearerToken',
          },
          body: list);

      log(list.toString());

      responseLogs = json.decode(reponse.body);

      log(reponse.body.toString());

      if (reponse.statusCode == 200 ||
          responseLogs['message'] == 'log recorded successfully!') {
        snackBar(navigatorKey.currentState!.context, 'Submitted', Colors.green);
      } else {
        snackBar(context, 'something went wrong', Colors.red);
      }
    } catch (e) {
      snackBar(context, 'error while submitting', Colors.red);

      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future getCalls(BuildContext context) async {
    allCallData.clear();
    DateTime currentDate = DateTime.now();

    try {
      await CallLog.get().then((value) {
        entries = value.toList();
      });

      for (var i in entries) {
        date = DateTime.fromMillisecondsSinceEpoch(i.timestamp! * 1000);

        allCallData.add({
          'dateTime': i.timestamp,
          'leadContact': i.number,
          'duration': i.duration,
          'personName': i.name,
          'status': i.callType,
        });
      }

      notifyListeners();

      int currentTimeToTimeStamp = currentDate.millisecondsSinceEpoch;
      const int twoDays = 2 * 24 * 60 * 60 * 1000;

      allCallData.removeWhere((map) {
        int timestamp = map["dateTime"];

        return currentTimeToTimeStamp - timestamp >= twoDays;
      });

      callsFunc();
    } catch (error) {
      snackBar(context, "Error fetching the call logs", Colors.red);
    }
  }

  //STORE THE CURRENT DATE DATA INTO ANOTHER LIST OF MAP
  callsFunc() {
    todayCalls.clear();
    yesterdayCalls.clear();
    olderCalls.clear();
    DateTime currentDate = DateTime.now();

    // Convert the timestamp of each item into a DateTime object
    final List<Map<String, dynamic>> itemsWithDate = allCallData.map((item) {
      return {
        'dateTime': DateTime.fromMillisecondsSinceEpoch(item['dateTime']),
        'leadContact': item['leadContact'],
        'duration': item['duration'],
        'personName': item['personName'],
        'status': item['status'],
      };
    }).toList();

    Iterable<Map<String, dynamic>> todayData = itemsWithDate.where(
      (element) => element['dateTime'].day == currentDate.day,
    );
    todayCalls.addAll(todayData);

    DateTime dayBeforeYesterday = currentDate.subtract(Duration(days: 2));

    //GET THE YESTERDAY DATE AND TIME DETAILS
    DateTime yesterday = currentDate.subtract(Duration(days: 1));

    Iterable<Map<String, dynamic>> yesterdayData = itemsWithDate.where(
      (element) => element['dateTime'].day == yesterday.day,
    );
    yesterdayCalls.addAll(yesterdayData);

    Iterable<Map<String, dynamic>> dayBeforeYesterdayData = itemsWithDate.where(
      (element) => element['dateTime'].day == dayBeforeYesterday.day,
    );
    olderCalls.addAll(dayBeforeYesterdayData);
  }

  // CALL DURATION CONVERTION
  String duration(
    int seconds,
  ) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return minutes == 0
        ? "$remainingSeconds sec"
        : "$minutes min $remainingSeconds sec";
  }

  // FORMATE THE DATE
  String FormateDate(int time) {
    return DateFormat('yyyy-MM-dd hh:mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  String dateTimeObject(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTime));
  }

  // SEND THE DATA IN THE STARTING OF THE APPLICATION
  sendCallLogsInStart(BuildContext context) async {
    await getCalls(context);
    todayCalls;
    yesterdayCalls;
    olderCalls;
    List<Map<String, dynamic>> sendAllData =
        todayCalls + yesterdayCalls + olderCalls;

    sendAllData.forEach((item) {
      if (item['status'] == CallType.outgoing) {
        item['status'] = 'Dialed call';
      } else if (item['status'] == CallType.incoming) {
        item['status'] = 'Recieved call';
      } else if (item['status'] == CallType.missed) {
        item['status'] = 'Missed call';
      } else if (item['status'] == CallType.rejected) {
        item['status'] = 'Rejected call';
      } else {
        item['status'] = 'Unknown call';
      }

      item['dateTime'] =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(item['dateTime']);

      callLogsList.add({
        "leadContact": item['leadContact'].toString(),
        'dateTime': item["dateTime"].toString(),
        'duration': item["duration"].toString(),
        'status': item["status"].toString(),
      });
    });
    await callLogApi(context);
    callLogsList.clear();
  }
}
