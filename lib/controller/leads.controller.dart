import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/model/lead.model.dart';

import '../utils/const.dart';

class LeadController extends ChangeNotifier {
  Map<String, dynamic>? responseOfLeads;
  late LeadModel leadModel;

  int? totalPages;

  ScrollController leadsScrollController = ScrollController();

  Future getLeadsData({bool refresh = false}) async {
    try {
      final reponse =
          await http.get(Uri.parse('${Urls.leads}?page=1'), headers: {
        'Authorization': 'Bearer $bearerToken',
      });
      // .timeout(Duration(seconds: 5));

      responseOfLeads = json.decode(reponse.body);
      notifyListeners();
    }
    // on TimeoutException catch (_) {
    //   log("here in the time out one");
    // }
    catch (error) {
      log(error.toString());
    }
    leadModel = LeadModel.fromJson(responseOfLeads!);

    log("url:: ${Urls.leads}");
    log("Reponse===============>");
    log(responseOfLeads.toString());

    return leadModel;
  }

  Future getData() async {
    await getLeadsData();
    notifyListeners();
  }
}
